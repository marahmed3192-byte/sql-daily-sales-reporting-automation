USE [RetailSalesAutomation]
GO

/****** Object:  Table [dbo].[Sales_Raw]    Script Date: 13-11-2026 21:47:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sales_Raw](
	[Sales_Raw_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Transaction_ID] [nvarchar](50) NULL,
	[Transaction_Date] [date] NULL,
	[Store_ID] [nvarchar](50) NULL,
	[Product_ID] [nvarchar](50) NULL,
	[Category] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Unit_Price] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Payment_Method] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Sales_Raw_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

