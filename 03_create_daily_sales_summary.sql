USE [RetailSalesAutomation]
GO

/****** Object:  Table [dbo].[Daily_Sales_Summary]    Script Date: 14-11-2026 11:43:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Daily_Sales_Summary](
	[Summary_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Transaction_Date] [date] NULL,
	[Store_ID] [varchar](20) NULL,
	[Total_Transactions] [int] NULL,
	[Total_Quantity] [int] NULL,
	[Total_Revenue] [decimal](18, 2) NULL,
	[Last_Updated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Summary_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

