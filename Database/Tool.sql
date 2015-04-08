CREATE TABLE [dbo].[Tools] (
    [ToolID]     INT            IDENTITY (1, 1) NOT NULL,
    [CategoryID] INT            NOT NULL,
    [Name]       NVARCHAR (255) NOT NULL,
    [Count]      INT            NOT NULL,
    [IsDeleted]  BIT            NULL,
	[CreationDate] [datetime] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [PK_Tool] PRIMARY KEY CLUSTERED ([ToolID] ASC),
    CONSTRAINT [FK_Tools_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Categories] ([CategoryID])
);

