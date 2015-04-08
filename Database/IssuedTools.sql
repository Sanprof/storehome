CREATE TABLE [dbo].[IssuedTools] (
    [IssuedToolID]     INT      IDENTITY (1, 1) NOT NULL,
    [ToolID]           INT      NOT NULL,
    [WorkerID]         INT      NOT NULL,
    [IssuedWorkerID]   INT      NOT NULL,
    [IssuedTime]       DATETIME DEFAULT (getdate()) NOT NULL,
    [IssuedCount]      INT      DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_IssuedTool] PRIMARY KEY CLUSTERED ([IssuedToolID] ASC),
    CONSTRAINT [FK_IssuedTools_Tools] FOREIGN KEY ([ToolID]) REFERENCES [dbo].[Tools] ([ToolID]),
    CONSTRAINT [FK_IssuedTools_Worker] FOREIGN KEY ([WorkerID]) REFERENCES [dbo].[Workers] ([WorkerID]),
    CONSTRAINT [FK_IssuedTools_IssuedWorkers] FOREIGN KEY ([IssuedWorkerID]) REFERENCES [dbo].[Workers] ([WorkerID])
);

