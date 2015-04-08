CREATE TABLE [dbo].[ToolsUses] (
    [ToolsUseID]   INT      IDENTITY (1, 1) NOT NULL,
    [ToolID]         INT      NOT NULL,
    [WorkerID]       INT      NOT NULL,
    [ManageWorkerID] INT      NOT NULL,
    [Count]    INT      DEFAULT ((1)) NOT NULL,
    [CreationDate]     DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ToolsUse] PRIMARY KEY CLUSTERED ([ToolsUseID] ASC),
    CONSTRAINT [FK_ToolsUses_Tools] FOREIGN KEY ([ToolID]) REFERENCES [dbo].[Tools] ([ToolID]),
    CONSTRAINT [FK_ToolsUses_Worker] FOREIGN KEY ([WorkerID]) REFERENCES [dbo].[Workers] ([WorkerID]),
    CONSTRAINT [FK_ToolsUses_ManageWorkers] FOREIGN KEY ([ManageWorkerID]) REFERENCES [dbo].[Workers] ([WorkerID])
);