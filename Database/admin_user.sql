INSERT INTO [dbo].[Positions] (Name, Description, IsDeleted, CreationDate) VALUES ('Управляющий', '', 0, GETDATE());
GO

INSERT INTO [dbo].[Workers] 
(
PositionID, FirstName, LastName, MiddleName, IsDeleted, CreationDate
)
VALUES
(
	1, 'Admin', 'Admin', 'Admin', 0, GETDATE()
)
GO

INSERT INTO [dbo].[User]
           ([WorkerID]
		   ,[UserName]
           ,[Email]
           ,[Password]
           ,[Salt]
           ,[IsDeleted]
           ,[CreatedDate])
     VALUES(1,'admin','admin','C73A384ADFD5DE689D86A4A9A2EAE8AE221DA3BB',12345,0,GETUTCDATE())