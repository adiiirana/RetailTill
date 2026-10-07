using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace PosDataObject
{
    public class UnpaidInvoice
    {
        private SqlConnection sqlConn;

        public SqlConnection Connection
        {
            get { return sqlConn; }
            set { sqlConn = value; }
        }

        public UnpaidInvoice()
        {
        }

        public DataTable FetchData()
        {
            DataTable dtbl = new DataTable();
            string strSQLComm = @"
                SELECT 
                    i.ID AS InvoiceID,
                    t.TransDate AS Date,
                    c.FirstName + ' ' + c.LastName AS Customer,
                    i.TotalSale AS Total,
                    (i.TotalSale - ISNULL((SELECT SUM(TenderAmount) FROM Tender WHERE TransactionNo = i.TransactionNo), 0)) AS AmountDue,
                    e.FirstName + ' ' + e.LastName AS AssignedStaff,
                    (SELECT TOP 1 Description FROM Item WHERE InvoiceNo = i.ID ORDER BY ID) AS FirstItem,
                    CASE 
                        WHEN ISNULL((SELECT SUM(TenderAmount) FROM Tender WHERE TransactionNo = i.TransactionNo), 0) = 0 THEN 'Unpaid'
                        ELSE 'Part-Paid'
                    END AS PaymentStatus
                FROM Invoice i
                LEFT JOIN Trans t ON i.TransactionNo = t.ID
                LEFT JOIN Customer c ON i.CustomerID = c.ID
                LEFT JOIN Employee e ON t.EmployeeID = e.ID
                WHERE i.TotalSale > ISNULL((SELECT SUM(TenderAmount) FROM Tender WHERE TransactionNo = i.TransactionNo), 0)
                ORDER BY t.TransDate DESC";

            SqlCommand objSQlComm = new SqlCommand(strSQLComm, sqlConn);
            SqlDataReader objSQLReader = null;

            try
            {
                if (sqlConn.State == System.Data.ConnectionState.Closed) { sqlConn.Open(); }
                objSQLReader = objSQlComm.ExecuteReader();
                dtbl.Load(objSQLReader);
            }
            catch (SqlException SQLDBException)
            {
                MessageBox.Show("Database Error: " + SQLDBException.Message);
                return null;
            }
            finally
            {
                if (objSQLReader != null) objSQLReader.Close();
                if (sqlConn.State == System.Data.ConnectionState.Open) { sqlConn.Close(); }
                if (objSQlComm != null) objSQlComm.Dispose();
            }
            return dtbl;
        }
    }
}
