CREATE TABLE [dbo].[DeletedTools] (
    [DeletedToolID] INT      IDENTITY (1, 1) NOT NULL,
    [WorkerID]      INT      NOT NULL,
    [ToolID]        INT      NOT NULL,
    [DeletedDate]   DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DeletedTool] PRIMARY KEY CLUSTERED ([DeletedToolID] ASC),
    CONSTRAINT [FK_DeletedTools_Workers] FOREIGN KEY ([WorkerID]) REFERENCES [dbo].[Workers] ([WorkerID]),
    CONSTRAINT [FK_DeletedTools_Tools] FOREIGN KEY ([ToolID]) REFERENCES [dbo].[Tools] ([ToolID])
);

