using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Reflection;
using System.ServiceProcess;
using System.Xml;

namespace OfflineRetailV2.Data
{
    public enum CloudSyncStatusKind
    {
        Hidden,
        Offline,
        Connected,
        ServiceStopped
    }

    public sealed class CloudSyncStatusInfo
    {
        public CloudSyncStatusKind Status { get; set; }
        public string StatusText { get; set; }
        public string ToolTipText { get; set; }
        public DateTime? LastSyncDateTime { get; set; }
        public bool IsSyncedRecently { get; set; }
    }

    public static class CloudSyncStatusHelper
    {
        public const string SyncBridgeServiceName = "XEPOS Cloud Sync Service";

        public static bool IsNewXEPOSCloudEnabled()
        {
            //string value = ReadAppConfigValue("EnableNewXEPOSCloud");
            //return !string.IsNullOrEmpty(value)
            //    && value.Equals("true", StringComparison.OrdinalIgnoreCase);
            return true;
        }

        public static bool IsSyncBridgeServiceRunning()
        {
            try
            {
                var services = ServiceController.GetServices();
                bool isRunning = false;
                foreach (var service in services)
                {
                    if (service.ServiceName.Equals(SyncBridgeServiceName, StringComparison.OrdinalIgnoreCase) ||
                        service.ServiceName.Equals("XEPOSCloudSync", StringComparison.OrdinalIgnoreCase) ||
                        service.DisplayName.Equals(SyncBridgeServiceName, StringComparison.OrdinalIgnoreCase) ||
                        service.DisplayName.Equals("XEPOS Cloud Sync Service", StringComparison.OrdinalIgnoreCase))
                    {
                        if (service.Status == ServiceControllerStatus.Running)
                        {
                            isRunning = true;
                        }
                    }
                    service.Dispose();
                }
                return isRunning;
            }
            catch
            {
                return false;
            }
        }

        public static CloudSyncStatusInfo GetCurrentStatus()
        {
            if (!IsNewXEPOSCloudEnabled())
            {
                return new CloudSyncStatusInfo
                {
                    Status = CloudSyncStatusKind.Hidden,
                    StatusText = string.Empty,
                    ToolTipText = string.Empty,
                    IsSyncedRecently = false
                };
            }

            bool isCloudEnabled = IsCloudSyncConfigured(out DateTime? lastSync, out string storeName, out string storeCode);

            if (!isCloudEnabled)
            {
                return new CloudSyncStatusInfo
                {
                    Status = CloudSyncStatusKind.Offline,
                    StatusText = "Offline",
                    ToolTipText = "Cloud sync is not configured.",
                    LastSyncDateTime = lastSync,
                    IsSyncedRecently = false
                };
            }

            bool serviceRunning = IsSyncBridgeServiceRunning();
            if (!serviceRunning)
            {
                return new CloudSyncStatusInfo
                {
                    Status = CloudSyncStatusKind.ServiceStopped,
                    StatusText = "Sync stopped",
                    ToolTipText = BuildConnectedToolTip(storeCode, storeName, lastSync,
                        "Sync bridge service is not running."),
                    LastSyncDateTime = lastSync,
                    IsSyncedRecently = false
                };
            }

            bool isSyncedRecently = lastSync.HasValue &&
                                    (DateTime.Now - lastSync.Value).TotalMinutes <= 30 &&
                                    (DateTime.Now - lastSync.Value).TotalMinutes >= -30;

            if (!isSyncedRecently)
            {
                return new CloudSyncStatusInfo
                {
                    Status = CloudSyncStatusKind.Connected,
                    StatusText = "Out of Sync",
                    ToolTipText = BuildConnectedToolTip(storeCode, storeName, lastSync,
                        "Last sync was more than 30 minutes ago."),
                    LastSyncDateTime = lastSync,
                    IsSyncedRecently = false
                };
            }

            return new CloudSyncStatusInfo
            {
                Status = CloudSyncStatusKind.Connected,
                StatusText = "Connected",
                ToolTipText = BuildConnectedToolTip(storeCode, storeName, lastSync, null),
                LastSyncDateTime = lastSync,
                IsSyncedRecently = true
            };
        }

        public static bool IsCloudSyncConfigured()
        {
            DateTime? lastSync;
            string storeName;
            string storeCode;
            return IsCloudSyncConfigured(out lastSync, out storeName, out storeCode);
        }

        private static bool IsCloudSyncConfigured(out DateTime? lastSync, out string storeName, out string storeCode)
        {
            lastSync = null;
            storeName = string.Empty;
            storeCode = string.Empty;

            if (!IsNewXEPOSCloudEnabled() || SystemVariables.Conn == null)
            {
                return false;
            }

            try
            {
                const string sql = "SELECT TOP 1 Token, LastSyncDate, CloudId, BusinessName FROM dbo.BusinessInfo";
                using (SqlCommand cmd = new SqlCommand(sql, SystemVariables.Conn))
                {
                    if (SystemVariables.Conn.State == ConnectionState.Closed)
                    {
                        SystemVariables.Conn.Open();
                    }

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return false;
                        }

                        string token = reader["Token"] != DBNull.Value
                            ? reader["Token"].ToString()
                            : string.Empty;
                        bool isCloudEnabled = !string.IsNullOrEmpty(token);

                        if (reader["LastSyncDate"] != DBNull.Value
                            && DateTime.TryParse(reader["LastSyncDate"].ToString(), out DateTime parsedLastSync))
                        {
                            lastSync = parsedLastSync;
                        }

                        storeName = reader["BusinessName"] != DBNull.Value
                            ? reader["BusinessName"].ToString()
                            : string.Empty;
                        storeCode = reader["CloudId"] != DBNull.Value
                            ? reader["CloudId"].ToString()
                            : string.Empty;
                        return isCloudEnabled;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private static string BuildConnectedToolTip(string storeCode, string storeName, DateTime? lastSync, string extraMessage)
        {
            string storeLabel = !string.IsNullOrWhiteSpace(storeCode)
                ? storeCode
                : (!string.IsNullOrWhiteSpace(storeName) ? storeName : "Store");

            string lastSyncLabel = lastSync.HasValue
                ? "Last sync: " + lastSync.Value.ToString("g")
                : "Last sync: not available";

            if (!string.IsNullOrWhiteSpace(extraMessage))
            {
                return storeLabel + Environment.NewLine + lastSyncLabel + Environment.NewLine + extraMessage;
            }

            return storeLabel + Environment.NewLine + lastSyncLabel;
        }

        private static string ReadAppConfigValue(string key)
        {
            if (string.IsNullOrWhiteSpace(key))
            {
                return string.Empty;
            }

            string envValue = Environment.GetEnvironmentVariable(key);
            if (!string.IsNullOrEmpty(envValue))
            {
                return envValue;
            }

            string value = ReadFromConfigFile(GeneralFunctions.GetUserConfigFile(), key);
            if (!string.IsNullOrEmpty(value))
            {
                return value;
            }

            try
            {
                string exePath = Assembly.GetExecutingAssembly().Location;
                if (!string.IsNullOrWhiteSpace(exePath))
                {
                    string exeConfig = Path.Combine(
                        Path.GetDirectoryName(exePath),
                        Path.GetFileName(exePath) + ".config");
                    value = ReadFromConfigFile(exeConfig, key);
                    if (!string.IsNullOrEmpty(value))
                    {
                        return value;
                    }
                }
            }
            catch
            {
            }

            return string.Empty;
        }

        private static string ReadFromConfigFile(string configFilePath, string key)
        {
            if (string.IsNullOrWhiteSpace(configFilePath) || !File.Exists(configFilePath))
            {
                return string.Empty;
            }

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(configFilePath);

                XmlNodeList addNodes = doc.SelectNodes("//appSettings/add[@key='" + key + "']");
                if (addNodes != null && addNodes.Count > 0)
                {
                    XmlAttribute valueAttr = addNodes[0].Attributes["value"];
                    if (valueAttr != null)
                    {
                        return valueAttr.Value ?? string.Empty;
                    }
                }

                XmlNodeList legacyNodes = doc.GetElementsByTagName(key);
                for (int i = 0; i < legacyNodes.Count; i++)
                {
                    if (legacyNodes[i].ParentNode != null
                        && legacyNodes[i].ParentNode.Name == "appSettings"
                        && legacyNodes[i].Name == key)
                    {
                        return legacyNodes[i].InnerText ?? string.Empty;
                    }
                }
            }
            catch
            {
            }

            return string.Empty;
        }
    }
}
