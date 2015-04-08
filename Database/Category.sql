CREATE TABLE [dbo].[Categories] (
    [CategoryID]  INT             IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255)  NOT NULL,
    [Description] NVARCHAR (1000) NULL,
	[IsDeleted][bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);

