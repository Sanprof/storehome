/****** Object:  Table [dbo].[Positions]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Positions](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CellFrom] [int] NOT NULL,
	[CellTo] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[AccessLevel] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Workers]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workers](
	[WorkerID] [int] IDENTITY(1,1) NOT NULL,
	[PositionID] [int] NOT NULL,
	[LastName] [nvarchar](192) NOT NULL,
	[FirstName] [nvarchar](192) NOT NULL,
	[MiddleName] [nvarchar](192) NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Worker] PRIMARY KEY CLUSTERED 
(
	[WorkerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tools]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tools](
	[ToolID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Count] [int] NOT NULL,
	[Cell] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
	[LowCount] [int] NULL,
	[LowerCount] [int] NULL,
 CONSTRAINT [PK_Tool] PRIMARY KEY CLUSTERED 
(
	[ToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WriteOffTools]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WriteOffTools](
	[WriteOffToolID] [int] IDENTITY(1,1) NOT NULL,
	[ToolID] [int] NOT NULL,
	[WorkerID] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[Comment] [nvarchar](192) NOT NULL,
	[WriteOffTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WriteOff] PRIMARY KEY CLUSTERED 
(
	[WriteOffToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeletedTools]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeletedTools](
	[DeletedToolID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[ToolID] [int] NOT NULL,
	[DeletedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DeletedTool] PRIMARY KEY CLUSTERED 
(
	[DeletedToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSession]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserSession](
	[UserSessionID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[Token] [varchar](24) NULL,
	[Expired] [datetime] NOT NULL,
	[RememberMe] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserSession] PRIMARY KEY CLUSTERED 
(
	[UserSessionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_User_Worker_Token] UNIQUE NONCLUSTERED 
(
	[WorkerID] ASC,
	[Token] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[UserTypeID] [int] NOT NULL,
	[UserName] [nvarchar](64) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [varchar](40) NOT NULL,
	[Salt] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_User] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [U_User_Email] ON [dbo].[User] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [U_User_Username] ON [dbo].[User] 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToolsUses]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToolsUses](
	[ToolsUseID] [int] IDENTITY(1,1) NOT NULL,
	[ToolID] [int] NOT NULL,
	[WorkerID] [int] NOT NULL,
	[ManageWorkerID] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ToolsUse] PRIMARY KEY CLUSTERED 
(
	[ToolsUseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audit]    Script Date: 04/24/2015 22:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[ToolID] [int] NOT NULL,
	[Action] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[Readed] [bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Get_UsersUsedTool]    Script Date: 04/24/2015 22:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_UsersUsedTool] 
	@ToolID int
AS
BEGIN
	SELECT sel.ToolID, t.Name, sel.WorkerID, w.LastName, w.FirstName, w.MiddleName, sel.Count 
	FROM 
		(SELECT ToolID, WorkerID, ABS(SUM([Count])) [Count]
		FROM [dbo].[ToolsUses]
		Where Toolid = @ToolID
		GROUP BY WorkerID, ToolID
		HAVING ABS(SUM([Count])) > 0) sel
	INNER JOIN
		[dbo].[Workers] w ON sel.WorkerID = w.WorkerID
	INNER JOIN
		[dbo].[Tools] t ON sel.ToolID = t.ToolID
	INNER JOIN
		[dbo].[Categories] c ON t.CategoryID = c.CategoryID
	WHERE c.IsDeleted = 0
	AND   (t.IsDeleted IS NULL OR t.IsDeleted = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[Get_ToolsUsedByUser]    Script Date: 04/24/2015 22:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_ToolsUsedByUser] 
	@WorkerID int
AS
BEGIN
	SELECT sel.ToolID, t.Name, sel.WorkerID, sel.Count 
	FROM 
		(SELECT ToolID, WorkerID, ABS(SUM([Count])) [Count]
		FROM [dbo].[ToolsUses]
		WHERE WorkerID = @WorkerID
		GROUP BY WorkerID, ToolID
		HAVING ABS(SUM([Count])) > 0) sel
	INNER JOIN
		[dbo].[Workers] w ON sel.WorkerID = w.WorkerID
	INNER JOIN
		[dbo].[Tools] t ON sel.ToolID = t.ToolID
	INNER JOIN
		[dbo].[Categories] c ON t.CategoryID = c.CategoryID
	WHERE c.IsDeleted = 0
	AND   (t.IsDeleted IS NULL OR t.IsDeleted = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByUserID]    Script Date: 04/24/2015 22:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexander Popov
-- Create date: 2015/24/02
-- Description:	Delete all user sessions that equals UserID
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUserSessionsByUserID]
(
	@WorkerID int
)
AS
BEGIN
	DELETE FROM [dbo].[UserSession]
	WHERE		[WorkerID] = @WorkerID;
	SELECT @@ROWCOUNT;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByToken]    Script Date: 04/24/2015 22:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexander Popov
-- Create date: 2015/24/02
-- Description:	Delete user session that equals Token
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUserSessionsByToken]
(
	@Token varchar(24)
)
AS
BEGIN
	DELETE FROM [dbo].[UserSession]
	WHERE		[Token] = @Token;
	SELECT @@ROWCOUNT;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpiredSessions]    Script Date: 04/24/2015 22:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexander Popov
-- Create date: 2015/24/02
-- Description:	Delete all user sessions that was expired
-- =============================================
CREATE PROCEDURE [dbo].[DeleteExpiredSessions]
(
	@DateOlder datetime
)
AS
BEGIN
	DELETE FROM [dbo].[UserSession]
	WHERE		[Expired] <= @DateOlder;
	SELECT @@ROWCOUNT;
END
GO
/****** Object:  Default [DF__Positions__Creat__1920BF5C]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Positions] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__Categorie__CellF__173876EA]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [CellFrom]
GO
/****** Object:  Default [DF__Categorie__CellT__182C9B23]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [CellTo]
GO
/****** Object:  Default [DF_UserType_AccessLevel]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[UserType] ADD  CONSTRAINT [DF_UserType_AccessLevel]  DEFAULT ((1)) FOR [AccessLevel]
GO
/****** Object:  Default [DF__UserType__Creati__1A14E395]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[UserType] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__Workers__Creatio__1BFD2C07]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Workers] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__Tools__Cell__1CF15040]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Tools] ADD  DEFAULT ((0)) FOR [Cell]
GO
/****** Object:  Default [DF__Tools__CreationD__1DE57479]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Tools] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__WriteOffT__Count__1ED998B2]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT ((1)) FOR [Count]
GO
/****** Object:  Default [DF__WriteOffT__Comme__1FCDBCEB]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT ('') FOR [Comment]
GO
/****** Object:  Default [DF__WriteOffT__Write__20C1E124]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT (getdate()) FOR [WriteOffTime]
GO
/****** Object:  Default [DF__DeletedTo__Delet__21B6055D]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[DeletedTools] ADD  DEFAULT (getdate()) FOR [DeletedDate]
GO
/****** Object:  Default [DF__UserSession__CreatedDate]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[UserSession] ADD  CONSTRAINT [DF__UserSession__CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_User_UserTypeID]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_UserTypeID]  DEFAULT ((1)) FOR [UserTypeID]
GO
/****** Object:  Default [DF_User_IsDeleted]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__ToolsUses__Count__25869641]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[ToolsUses] ADD  DEFAULT ((1)) FOR [Count]
GO
/****** Object:  Default [DF__ToolsUses__Creat__267ABA7A]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[ToolsUses] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__Audit__CreationD__403A8C7D]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Audit] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  ForeignKey [FK_Worker_Position]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Workers]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([PositionID])
GO
ALTER TABLE [dbo].[Workers] CHECK CONSTRAINT [FK_Worker_Position]
GO
/****** Object:  ForeignKey [FK_Tools_Categories]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Tools]  WITH CHECK ADD  CONSTRAINT [FK_Tools_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Tools] CHECK CONSTRAINT [FK_Tools_Categories]
GO
/****** Object:  ForeignKey [FK_WriteOffTools_Tools]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[WriteOffTools]  WITH CHECK ADD  CONSTRAINT [FK_WriteOffTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[WriteOffTools] CHECK CONSTRAINT [FK_WriteOffTools_Tools]
GO
/****** Object:  ForeignKey [FK_WriteOffTools_Workers]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[WriteOffTools]  WITH CHECK ADD  CONSTRAINT [FK_WriteOffTools_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[WriteOffTools] CHECK CONSTRAINT [FK_WriteOffTools_Workers]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Tools]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Tools]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Workers]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Workers]
GO
/****** Object:  ForeignKey [FK_UserSession_Worker]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[UserSession]  WITH NOCHECK ADD  CONSTRAINT [FK_UserSession_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[UserSession] CHECK CONSTRAINT [FK_UserSession_Worker]
GO
/****** Object:  ForeignKey [FK_User_UserType]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_UserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserType] ([UserTypeID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_UserType]
GO
/****** Object:  ForeignKey [FK_User_Workers]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Workers]
GO
/****** Object:  ForeignKey [FK_ToolsUses_ManageWorkers]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_ManageWorkers] FOREIGN KEY([ManageWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_ManageWorkers]
GO
/****** Object:  ForeignKey [FK_ToolsUses_Tools]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_Tools]
GO
/****** Object:  ForeignKey [FK_ToolsUses_Worker]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_Worker]
GO
/****** Object:  ForeignKey [FK_Audit_Tools]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_Tools]
GO
/****** Object:  ForeignKey [FK_Audit_Worker]    Script Date: 04/24/2015 22:22:09 ******/
ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_Worker]
GO
