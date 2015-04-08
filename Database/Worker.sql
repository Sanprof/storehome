CREATE TABLE [dbo].[Workers] (
    [WorkerID]     INT            IDENTITY (1, 1) NOT NULL,
    [PositionID]   INT            NOT NULL,
    [LastName]     NVARCHAR (192) NOT NULL,
    [FirstName]    NVARCHAR (192) NOT NULL,
    [MiddleName]   NVARCHAR (192) NOT NULL,
    [IsDeleted]    BIT            NULL,
    [CreationDate] DATETIME       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Worker] PRIMARY KEY CLUSTERED ([WorkerID] ASC),
    CONSTRAINT [FK_Worker_Position] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[Positions] ([PositionID])
);

