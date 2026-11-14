USE [RetailSalesAutomation]
GO

/****** Object:  Table [dbo].[DataQuality_Audit]    Script Date: 14-11-2026 11:42:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataQuality_Audit](
	[Audit_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Check_Name] [nvarchar](50) NULL,
	[Failed_Records] [int] NULL,
	[Check_Date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Audit_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

