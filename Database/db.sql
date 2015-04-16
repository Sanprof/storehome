USE [master]
GO
/****** Object:  Database [serg_test]    Script Date: 04/15/2015 23:45:17 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'serg_test')
BEGIN
CREATE DATABASE [serg_test] ON  PRIMARY 
( NAME = N'serg_test', FILENAME = N'D:\SANPROF\storehome\StoreHouse\App_Data\serg_test.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'serg_test_log', FILENAME = N'D:\SANPROF\storehome\StoreHouse\App_Data\serg_test_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [serg_test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [serg_test] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [serg_test] SET ANSI_NULLS OFF
GO
ALTER DATABASE [serg_test] SET ANSI_PADDING OFF
GO
ALTER DATABASE [serg_test] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [serg_test] SET ARITHABORT OFF
GO
ALTER DATABASE [serg_test] SET AUTO_CLOSE ON
GO
ALTER DATABASE [serg_test] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [serg_test] SET AUTO_SHRINK ON
GO
ALTER DATABASE [serg_test] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [serg_test] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [serg_test] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [serg_test] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [serg_test] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [serg_test] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [serg_test] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [serg_test] SET  DISABLE_BROKER
GO
ALTER DATABASE [serg_test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [serg_test] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [serg_test] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [serg_test] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [serg_test] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [serg_test] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [serg_test] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [serg_test] SET  READ_WRITE
GO
ALTER DATABASE [serg_test] SET RECOVERY SIMPLE
GO
ALTER DATABASE [serg_test] SET  MULTI_USER
GO
ALTER DATABASE [serg_test] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [serg_test] SET DB_CHAINING OFF
GO
USE [serg_test]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserType](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[Tools]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tools]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tools](
	[ToolID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Count] [int] NOT NULL,
	[Cell] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Tool] PRIMARY KEY CLUSTERED 
(
	[ToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Workers]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Workers]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[WriteOffTools]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WriteOffTools]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[DeletedTools]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletedTools]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[UserSession]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserSession]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserSession](
	[UserSessionID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[Token] [varchar](24) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Expired] [datetime] NOT NULL,
	[RememberMe] [bit] NOT NULL,
 CONSTRAINT [PK_UserSession] PRIMARY KEY CLUSTERED 
(
	[UserSessionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [varchar](40) NOT NULL,
	[Salt] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserName] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_User] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND name = N'U_User_Email')
CREATE UNIQUE NONCLUSTERED INDEX [U_User_Email] ON [dbo].[User] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND name = N'U_User_Username')
CREATE UNIQUE NONCLUSTERED INDEX [U_User_Username] ON [dbo].[User] 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToolsUses]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ToolsUses]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[IssuedTools]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IssuedTools]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IssuedTools](
	[IssuedToolID] [int] IDENTITY(1,1) NOT NULL,
	[ToolID] [int] NOT NULL,
	[WorkerID] [int] NOT NULL,
	[IssuedWorkerID] [int] NOT NULL,
	[IssuedTime] [datetime] NOT NULL,
	[IssuedCount] [int] NOT NULL,
 CONSTRAINT [PK_IssuedTool] PRIMARY KEY CLUSTERED 
(
	[IssuedToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IncomedTools]    Script Date: 04/15/2015 23:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncomedTools]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IncomedTools](
	[IncomedToolID] [int] IDENTITY(1,1) NOT NULL,
	[ToolID] [int] NOT NULL,
	[WorkerID] [int] NOT NULL,
	[IncomedWorkerID] [int] NOT NULL,
	[IncomedTime] [datetime] NOT NULL,
	[IncomedCount] [int] NOT NULL,
 CONSTRAINT [PK_IncomedTool] PRIMARY KEY CLUSTERED 
(
	[IncomedToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[Get_UsersUsedTool]    Script Date: 04/15/2015 23:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Get_UsersUsedTool]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Get_UsersUsedTool] 
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_ToolsUsedByUser]    Script Date: 04/15/2015 23:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Get_ToolsUsedByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Get_ToolsUsedByUser] 
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByUserID]    Script Date: 04/15/2015 23:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUserSessionsByUserID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByToken]    Script Date: 04/15/2015 23:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUserSessionsByToken]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpiredSessions]    Script Date: 04/15/2015 23:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteExpiredSessions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
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
' 
END
GO
/****** Object:  Default [DF__tmp_ms_xx__CellF__160F4887]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__CellF__160F4887]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__CellF__160F4887]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [CellFrom]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx__CellT__17036CC0]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__CellT__17036CC0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__CellT__17036CC0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [CellTo]
END


End
GO
/****** Object:  Default [DF__UserType__Creati__3C34F16F]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserType__Creati__3C34F16F]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserType]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__UserType__Creati__3C34F16F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserType] ADD  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF__Positions__Creat__25869641]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Positions__Creat__25869641]') AND parent_object_id = OBJECT_ID(N'[dbo].[Positions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Positions__Creat__25869641]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Positions] ADD  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx___Cell__1AD3FDA4]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx___Cell__1AD3FDA4]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx___Cell__1AD3FDA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Tools] ADD  DEFAULT ((0)) FOR [Cell]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx__Creat__1BC821DD]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__Creat__1BC821DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__Creat__1BC821DD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Tools] ADD  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF__Workers__Creatio__276EDEB3]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Workers__Creatio__276EDEB3]') AND parent_object_id = OBJECT_ID(N'[dbo].[Workers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Workers__Creatio__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Workers] ADD  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx__Count__29221CFB]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__Count__29221CFB]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__Count__29221CFB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT ((1)) FOR [Count]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx__Comme__2A164134]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__Comme__2A164134]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__Comme__2A164134]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT ('') FOR [Comment]
END


End
GO
/****** Object:  Default [DF__tmp_ms_xx__Write__2B0A656D]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_ms_xx__Write__2B0A656D]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__tmp_ms_xx__Write__2B0A656D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WriteOffTools] ADD  DEFAULT (getdate()) FOR [WriteOffTime]
END


End
GO
/****** Object:  Default [DF__DeletedTo__Delet__2A4B4B5E]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__DeletedTo__Delet__2A4B4B5E]') AND parent_object_id = OBJECT_ID(N'[dbo].[DeletedTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__DeletedTo__Delet__2A4B4B5E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DeletedTools] ADD  DEFAULT (getdate()) FOR [DeletedDate]
END


End
GO
/****** Object:  Default [DF__UserSession__CreatedDate]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserSession__CreatedDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserSession]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__UserSession__CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserSession] ADD  CONSTRAINT [DF__UserSession__CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
END


End
GO
/****** Object:  Default [DF_User_IsDeleted]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_User_IsDeleted]') AND parent_object_id = OBJECT_ID(N'[dbo].[User]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_User_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF__ToolsUses__Count__5CD6CB2B]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__ToolsUses__Count__5CD6CB2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ToolsUses__Count__5CD6CB2B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ToolsUses] ADD  DEFAULT ((1)) FOR [Count]
END


End
GO
/****** Object:  Default [DF__ToolsUses__Creat__5DCAEF64]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__ToolsUses__Creat__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ToolsUses__Creat__5DCAEF64]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ToolsUses] ADD  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF__IssuedToo__Issue__2D27B809]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IssuedToo__Issue__2D27B809]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IssuedToo__Issue__2D27B809]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT (getdate()) FOR [IssuedTime]
END


End
GO
/****** Object:  Default [DF__IssuedToo__Issue__2E1BDC42]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IssuedToo__Issue__2E1BDC42]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IssuedToo__Issue__2E1BDC42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT ((1)) FOR [IssuedCount]
END


End
GO
/****** Object:  Default [DF__IncomedTo__Incom__2F10007B]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IncomedTo__Incom__2F10007B]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IncomedTo__Incom__2F10007B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IncomedTools] ADD  DEFAULT (getdate()) FOR [IncomedTime]
END


End
GO
/****** Object:  Default [DF__IncomedTo__Incom__300424B4]    Script Date: 04/15/2015 23:45:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IncomedTo__Incom__300424B4]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IncomedTo__Incom__300424B4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IncomedTools] ADD  DEFAULT ((1)) FOR [IncomedCount]
END


End
GO
/****** Object:  ForeignKey [FK_Tools_Categories]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tools_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tools]'))
ALTER TABLE [dbo].[Tools]  WITH CHECK ADD  CONSTRAINT [FK_Tools_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tools_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tools]'))
ALTER TABLE [dbo].[Tools] CHECK CONSTRAINT [FK_Tools_Categories]
GO
/****** Object:  ForeignKey [FK_Worker_Position]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Worker_Position]') AND parent_object_id = OBJECT_ID(N'[dbo].[Workers]'))
ALTER TABLE [dbo].[Workers]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([PositionID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Worker_Position]') AND parent_object_id = OBJECT_ID(N'[dbo].[Workers]'))
ALTER TABLE [dbo].[Workers] CHECK CONSTRAINT [FK_Worker_Position]
GO
/****** Object:  ForeignKey [FK_WriteOffTools_Tools]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WriteOffTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
ALTER TABLE [dbo].[WriteOffTools]  WITH CHECK ADD  CONSTRAINT [FK_WriteOffTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WriteOffTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
ALTER TABLE [dbo].[WriteOffTools] CHECK CONSTRAINT [FK_WriteOffTools_Tools]
GO
/****** Object:  ForeignKey [FK_WriteOffTools_Workers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WriteOffTools_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
ALTER TABLE [dbo].[WriteOffTools]  WITH CHECK ADD  CONSTRAINT [FK_WriteOffTools_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WriteOffTools_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[WriteOffTools]'))
ALTER TABLE [dbo].[WriteOffTools] CHECK CONSTRAINT [FK_WriteOffTools_Workers]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Tools]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DeletedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[DeletedTools]'))
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DeletedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[DeletedTools]'))
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Tools]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Workers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DeletedTools_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[DeletedTools]'))
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DeletedTools_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[DeletedTools]'))
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Workers]
GO
/****** Object:  ForeignKey [FK_UserSession_Worker]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserSession_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserSession]'))
ALTER TABLE [dbo].[UserSession]  WITH NOCHECK ADD  CONSTRAINT [FK_UserSession_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserSession_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserSession]'))
ALTER TABLE [dbo].[UserSession] CHECK CONSTRAINT [FK_UserSession_Worker]
GO
/****** Object:  ForeignKey [FK_User_Workers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_User_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[User]'))
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_User_Workers]') AND parent_object_id = OBJECT_ID(N'[dbo].[User]'))
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Workers]
GO
/****** Object:  ForeignKey [FK_ToolsUses_ManageWorkers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_ManageWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_ManageWorkers] FOREIGN KEY([ManageWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_ManageWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_ManageWorkers]
GO
/****** Object:  ForeignKey [FK_ToolsUses_Tools]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_Tools]
GO
/****** Object:  ForeignKey [FK_ToolsUses_Worker]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses]  WITH CHECK ADD  CONSTRAINT [FK_ToolsUses_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ToolsUses_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToolsUses]'))
ALTER TABLE [dbo].[ToolsUses] CHECK CONSTRAINT [FK_ToolsUses_Worker]
GO
/****** Object:  ForeignKey [FK_IssuedTools_IssuedWorkers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_IssuedWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_IssuedWorkers] FOREIGN KEY([IssuedWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_IssuedWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_IssuedWorkers]
GO
/****** Object:  ForeignKey [FK_IssuedTools_Tools]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_Tools]
GO
/****** Object:  ForeignKey [FK_IssuedTools_Worker]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IssuedTools_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[IssuedTools]'))
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_Worker]
GO
/****** Object:  ForeignKey [FK_IncomedTools_IncomedWorkers]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_IncomedWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools]  WITH CHECK ADD  CONSTRAINT [FK_IncomedTools_IncomedWorkers] FOREIGN KEY([IncomedWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_IncomedWorkers]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools] CHECK CONSTRAINT [FK_IncomedTools_IncomedWorkers]
GO
/****** Object:  ForeignKey [FK_IncomedTools_Tools]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools]  WITH CHECK ADD  CONSTRAINT [FK_IncomedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_Tools]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools] CHECK CONSTRAINT [FK_IncomedTools_Tools]
GO
/****** Object:  ForeignKey [FK_IncomedTools_Worker]    Script Date: 04/15/2015 23:45:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools]  WITH CHECK ADD  CONSTRAINT [FK_IncomedTools_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IncomedTools_Worker]') AND parent_object_id = OBJECT_ID(N'[dbo].[IncomedTools]'))
ALTER TABLE [dbo].[IncomedTools] CHECK CONSTRAINT [FK_IncomedTools_Worker]
GO