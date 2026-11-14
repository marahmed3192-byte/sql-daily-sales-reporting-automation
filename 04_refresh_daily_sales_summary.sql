USE [RetailSalesAutomation]
GO

/****** Object:  StoredProcedure [dbo].[usp_RefreshDailySalesSummary]    Script Date: 14-11-2026 11:44:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_RefreshDailySalesSummary]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION	;
		DELETE FROM dbo.Daily_Sales_Summary;
			
WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Transaction_ID, Product_ID
               ORDER BY Sales_Raw_ID
           ) AS duplicates
    FROM dbo.Sales_Raw
)
INSERT INTO dbo.Daily_Sales_Summary
(
    Transaction_Date,
    Store_ID,
    Total_Transactions,
    Total_Quantity,
    Total_Revenue,
    Last_Updated
)
SELECT
    Transaction_Date,
    Store_ID,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    SUM(Quantity) AS Total_Quantity,
    SUM((Quantity * Unit_Price) - Discount) AS Total_Revenue,
    GETDATE() AS Last_Updated
FROM CTE
WHERE duplicates = 1
  AND Transaction_ID IS NOT NULL
  AND Product_ID IS NOT NULL
  AND Unit_Price IS NOT NULL
  AND Quantity IS NOT NULL
  AND Discount IS NOT NULL
  AND Quantity > 0
  AND Unit_Price > 0
  AND Discount >= 0
  AND Discount <= (Quantity * Unit_Price)
GROUP BY Transaction_Date, Store_ID;

COMMIT TRANSACTION;
END TRY

BEGIN CATCH 
    IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;
END
GO

