USE [RetailSalesAutomation]
GO

/****** Object:  StoredProcedure [dbo].[usp_ValidateDailySales]    Script Date: 14-11-2026 11:44:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[usp_ValidateDailySales]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Missing Values
        INSERT INTO dbo.DataQuality_Audit
            (Check_Name, Failed_Records, Check_Date)
        SELECT 'Missing Values', COUNT(*), GETDATE()
        FROM dbo.Sales_Raw
        WHERE Transaction_ID IS NULL
           OR Product_ID IS NULL
           OR Quantity IS NULL
           OR Unit_Price IS NULL;

        -- 2. Invalid Quantity
        INSERT INTO dbo.DataQuality_Audit
            (Check_Name, Failed_Records, Check_Date)
        SELECT 'Invalid Quantity', COUNT(*), GETDATE()
        FROM dbo.Sales_Raw
        WHERE Quantity < 1;

        -- 3. Invalid Price
        INSERT INTO dbo.DataQuality_Audit
            (Check_Name, Failed_Records, Check_Date)
        SELECT 'Invalid Price', COUNT(*), GETDATE()
        FROM dbo.Sales_Raw
        WHERE Unit_Price <= 0;

        -- 4. Invalid Discount
        INSERT INTO dbo.DataQuality_Audit
            (Check_Name, Failed_Records, Check_Date)
        SELECT 'Invalid Discount', COUNT(*), GETDATE()
        FROM dbo.Sales_Raw
        WHERE Quantity > 0
          AND Unit_Price > 0
          AND (
              Discount < 0
              OR Discount > Quantity * Unit_Price
          );

        -- 5. Duplicate Records
        ;WITH CTE AS
        (
            SELECT
                Transaction_ID,
                Product_ID,
                COUNT(*) AS Duplicate_Count
            FROM dbo.Sales_Raw
            GROUP BY Transaction_ID, Product_ID
            HAVING COUNT(*) > 1
        )
        INSERT INTO dbo.DataQuality_Audit
            (Check_Name, Failed_Records, Check_Date)
        SELECT
            'Duplicate Records',
            COALESCE(SUM(Duplicate_Count), 0),
            GETDATE()
        FROM CTE;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH;
END;
GO

