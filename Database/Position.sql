CREATE TABLE [dbo].[Positions] (
    [PositionID]   INT             IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (255)  NOT NULL,
    [Description]  NVARCHAR (1000) NULL,
    [IsDeleted] [bit] NOT NULL,
	[CreationDate] DATETIME        DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED ([PositionID] ASC)
);

