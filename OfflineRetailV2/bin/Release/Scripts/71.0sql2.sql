IF NOT EXISTS (
    SELECT 1
    FROM [Retail2020DB].[dbo].[Dept]
    WHERE Description = 'General Department'
)
BEGIN
    -- Insert a new department
    INSERT INTO [Retail2020DB].[dbo].[Dept]
        (
            DepartmentID,
            Description,
            Selected,
            FoodStampEligible,
            Enabled,
            CreatedBy,
            CreatedOn,
            LastChangedBy,
            LastChangedOn,
            ScaleFlag,
            ScaleScreenVisible,
            ScaleDisplayOrder,
            LinkSalesGL,
            LinkCostGL,
            LinkPayableGL,
            LinkInventoryGL,
            BookerDepttID,
            BookerDeptID,
            IsDepartmentSale
        )
    VALUES
        (
            'GD-99999', -- next available DepartmentID
            'General Department',       -- Description
            NULL,                       -- Selected
            'N',                        -- FoodStampEligible
            'Y',                        -- Enabled
            2,                          -- CreatedBy
            GETDATE(),                  -- CreatedOn
            2,                          -- LastChangedBy
            GETDATE(),                  -- LastChangedOn
            'N',                        -- ScaleFlag
            'N',                        -- ScaleScreenVisible
            0,                          -- ScaleDisplayOrder
            0,                          -- LinkSalesGL
            0,                          -- LinkCostGL
            0,                          -- LinkPayableGL
            0,                          -- LinkInventoryGL
            NULL,                       -- BookerDepttID
            NULL,                       -- BookerDeptID
            1                           -- IsDepartmentSale
        );
END