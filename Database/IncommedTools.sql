CREATE TABLE [dbo].[IncomedTools] (
    [IncomedToolID]     INT      IDENTITY (1, 1) NOT NULL,
    [ToolID]           INT      NOT NULL,
    [WorkerID]         INT      NOT NULL,
    [IncomedWorkerID] INT      NOT NULL,
    [IncomedTime]     DATETIME DEFAULT (getdate()) NOT NULL,
    [IncomedCount]    INT      DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_IncomedTool] PRIMARY KEY CLUSTERED ([IncomedToolID] ASC),
    CONSTRAINT [FK_IncomedTools_Tools] FOREIGN KEY ([ToolID]) REFERENCES [dbo].[Tools] ([ToolID]),
    CONSTRAINT [FK_IncomedTools_Worker] FOREIGN KEY ([WorkerID]) REFERENCES [dbo].[Workers] ([WorkerID]),
    CONSTRAINT [FK_IncomedTools_IncomedWorkers] FOREIGN KEY ([IncomedWorkerID]) REFERENCES [dbo].[Workers] ([WorkerID]),
);
