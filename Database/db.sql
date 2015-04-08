USE [master]
GO
/****** Object:  Database [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF]    Script Date: 03/26/2015 22:30:11 ******/
CREATE DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] ON  PRIMARY 
( NAME = N'storage', FILENAME = N'D:\SANPROF\StoreHouse\StoreHouse\App_Data\storage.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'storage_log', FILENAME = N'D:\SANPROF\StoreHouse\StoreHouse\App_Data\storage_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ARITHABORT OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET AUTO_CLOSE ON
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET AUTO_SHRINK ON
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET  ENABLE_BROKER
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET  READ_WRITE
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET  MULTI_USER
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF] SET DB_CHAINING OFF
GO
USE [D:\SANPROF\STOREHOUSE\STOREHOUSE\APP_DATA\STORAGE.MDF]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 03/26/2015 22:30:12 ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 03/26/2015 22:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tools]    Script Date: 03/26/2015 22:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tools](
	[ToolID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Count] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Tool] PRIMARY KEY CLUSTERED 
(
	[ToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Workers]    Script Date: 03/26/2015 22:30:12 ******/
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
/****** Object:  Table [dbo].[DeletedTools]    Script Date: 03/26/2015 22:30:12 ******/
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
/****** Object:  Table [dbo].[UserSession]    Script Date: 03/26/2015 22:30:12 ******/
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
	[CreatedDate] [datetime] NOT NULL,
	[Expired] [datetime] NOT NULL,
	[RememberMe] [bit] NOT NULL,
 CONSTRAINT [PK_UserSession] PRIMARY KEY CLUSTERED 
(
	[UserSessionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 03/26/2015 22:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
/****** Object:  Table [dbo].[IssuedTools]    Script Date: 03/26/2015 22:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IssuedTools](
	[IssuedToolID] [int] IDENTITY(1,1) NOT NULL,
	[ToolID] [int] NOT NULL,
	[IssuedWorkerID] [int] NOT NULL,
	[IssuedTime] [datetime] NOT NULL,
	[IssuedCount] [int] NOT NULL,
	[IncomingWorkerID] [int] NOT NULL,
	[IncomingTime] [datetime] NOT NULL,
	[IncomingCount] [int] NOT NULL,
 CONSTRAINT [PK_IssuedTool] PRIMARY KEY CLUSTERED 
(
	[IssuedToolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByUserID]    Script Date: 03/26/2015 22:30:13 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteUserSessionsByToken]    Script Date: 03/26/2015 22:30:13 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteExpiredSessions]    Script Date: 03/26/2015 22:30:13 ******/
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
/****** Object:  Default [DF__tmp_ms_xx__Creat__3C34F16F]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[Positions] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__Tools__CreationD__05D8E0BE]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[Tools] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__tmp_ms_xx__Creat__114A936A]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[Workers] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
/****** Object:  Default [DF__DeletedTo__Delet__245D67DE]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[DeletedTools] ADD  DEFAULT (getdate()) FOR [DeletedDate]
GO
/****** Object:  Default [DF__UserSession__CreatedDate]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[UserSession] ADD  CONSTRAINT [DF__UserSession__CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF_User_IsDeleted]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__tmp_ms_xx__Issue__1BC821DD]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT (getdate()) FOR [IssuedTime]
GO
/****** Object:  Default [DF__tmp_ms_xx__Issue__1CBC4616]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT ((1)) FOR [IssuedCount]
GO
/****** Object:  Default [DF__tmp_ms_xx__Incom__1DB06A4F]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT (getdate()) FOR [IncomingTime]
GO
/****** Object:  Default [DF__tmp_ms_xx__Incom__1EA48E88]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools] ADD  DEFAULT ((1)) FOR [IncomingCount]
GO
/****** Object:  ForeignKey [FK_Tools_Categories]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[Tools]  WITH CHECK ADD  CONSTRAINT [FK_Tools_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Tools] CHECK CONSTRAINT [FK_Tools_Categories]
GO
/****** Object:  ForeignKey [FK_Worker_Position]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[Workers]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([PositionID])
GO
ALTER TABLE [dbo].[Workers] CHECK CONSTRAINT [FK_Worker_Position]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Tools]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Tools]
GO
/****** Object:  ForeignKey [FK_DeletedTools_Workers]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[DeletedTools]  WITH CHECK ADD  CONSTRAINT [FK_DeletedTools_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[DeletedTools] CHECK CONSTRAINT [FK_DeletedTools_Workers]
GO
/****** Object:  ForeignKey [FK_UserSession_Worker]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[UserSession]  WITH NOCHECK ADD  CONSTRAINT [FK_UserSession_Worker] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[UserSession] CHECK CONSTRAINT [FK_UserSession_Worker]
GO
/****** Object:  ForeignKey [FK_User_Workers]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Workers] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Workers]
GO
/****** Object:  ForeignKey [FK_IssuedTools_IncomingWorkers]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_IncomingWorkers] FOREIGN KEY([IncomingWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_IncomingWorkers]
GO
/****** Object:  ForeignKey [FK_IssuedTools_IssuedWorkers]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_IssuedWorkers] FOREIGN KEY([IssuedWorkerID])
REFERENCES [dbo].[Workers] ([WorkerID])
GO
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_IssuedWorkers]
GO
/****** Object:  ForeignKey [FK_IssuedTools_Tools]    Script Date: 03/26/2015 22:30:12 ******/
ALTER TABLE [dbo].[IssuedTools]  WITH CHECK ADD  CONSTRAINT [FK_IssuedTools_Tools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[Tools] ([ToolID])
GO
ALTER TABLE [dbo].[IssuedTools] CHECK CONSTRAINT [FK_IssuedTools_Tools]
GO
