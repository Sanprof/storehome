CREATE TABLE [dbo].[WorkerTypes] (
    [WorkerTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (192) NOT NULL,
    [CreationDate] DATETIME       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_WorkerType] PRIMARY KEY CLUSTERED ([WorkerTypeID] ASC)
);

