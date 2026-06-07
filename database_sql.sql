USE [master]
GO
/****** Object:  Database [DOUBLE2CAFE]    Script Date: 6/7/2026 11:25:12 AM ******/
CREATE DATABASE [DOUBLE2CAFE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DOUBLE2CAFE', FILENAME = N'C:\Users\user\Documents\UIB\Sistem Basis Data\Ms. SQL Server Express\MSSQL17.SQLEXPRESS\MSSQL\DATA\DOUBLE2CAFE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DOUBLE2CAFE_log', FILENAME = N'C:\Users\user\Documents\UIB\Sistem Basis Data\Ms. SQL Server Express\MSSQL17.SQLEXPRESS\MSSQL\DATA\DOUBLE2CAFE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DOUBLE2CAFE] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DOUBLE2CAFE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DOUBLE2CAFE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ARITHABORT OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DOUBLE2CAFE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DOUBLE2CAFE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DOUBLE2CAFE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DOUBLE2CAFE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DOUBLE2CAFE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DOUBLE2CAFE] SET  MULTI_USER 
GO
ALTER DATABASE [DOUBLE2CAFE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DOUBLE2CAFE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DOUBLE2CAFE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DOUBLE2CAFE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DOUBLE2CAFE] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [DOUBLE2CAFE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DOUBLE2CAFE] SET QUERY_STORE = ON
GO
ALTER DATABASE [DOUBLE2CAFE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DOUBLE2CAFE]
GO
/****** Object:  User [cafe_user]    Script Date: 6/7/2026 11:25:12 AM ******/
CREATE USER [cafe_user] FOR LOGIN [cafe_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [cafe_user]
GO
/****** Object:  Table [dbo].[ADMIN]    Script Date: 6/7/2026 11:25:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADMIN](
	[AdminID] [char](4) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [ADMPK] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 6/7/2026 11:25:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[CategoryID] [char](4) NOT NULL,
	[CategoryName] [varchar](30) NULL,
	[CatAddedBy] [varchar](4) NULL,
 CONSTRAINT [CATPK] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY_IMAGE]    Script Date: 6/7/2026 11:25:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY_IMAGE](
	[Cat_ID] [char](4) NOT NULL,
	[ImagePath] [varchar](255) NULL,
 CONSTRAINT [CATIMGPK] PRIMARY KEY CLUSTERED 
(
	[Cat_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 6/7/2026 11:25:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[MenuID] [char](4) NOT NULL,
	[MenuName] [varchar](30) NULL,
	[Price] [int] NULL,
	[CatID] [char](4) NOT NULL,
	[MenAddedBy] [varchar](4) NULL,
	[ShortDesc] [varchar](100) NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [MENUPK] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ADMIN] ([AdminID], [Username], [Password], [CreatedAt]) VALUES (N'A001', N'ADMIN', N'$2y$10$E4C7ZuQtC5D2OdYRuV4mWusU1DslZCu7Fu0JT4HmPaNU92Kg04Cei', CAST(N'2026-06-01T15:36:46.267' AS DateTime))
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C001', N'Ricebowl', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C002', N'Bihun', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C003', N'Nasi', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C004', N'Mie', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C005', N'Kwetiau', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C006', N'Indomie', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C007', N'Sagu Mie', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C008', N'Ayam', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C009', N'Lele', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C010', N'Ikan Selar', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C011', N'Ikan Dori', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C012', N'Udang', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C013', N'Sotong', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C014', N'Sayur', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C015', N'Sup', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C016', N'Tambahan', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C017', N'Minuman Panas', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C018', N'Minuman Kaleng', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C019', N'Jus', N'A001')
GO
INSERT [dbo].[CATEGORY] ([CategoryID], [CategoryName], [CatAddedBy]) VALUES (N'C020', N'Minuman Dingin', N'A001')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C001', N'Images/Ricebowl.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C002', N'Images/Bihun.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C003', N'Images/Nasi.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C004', N'Images/Mie.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C005', N'Images/Kwetiau.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C006', N'Images/Indomie.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C007', N'Images/Sagu mie.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C008', N'Images/Ayam.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C009', N'Images/Lele.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C010', N'Images/Ikan selar.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C011', N'Images/Ikan Dori.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C012', N'Images/Udang.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C013', N'Images/Sotong.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C014', N'Images/Sayur.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C015', N'Images/Soup.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C016', N'Images/Additional.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C017', N'Images/Minuman panas.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C018', N'Images/Minuman kaleng.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C019', N'Images/Jus.png')
GO
INSERT [dbo].[CATEGORY_IMAGE] ([Cat_ID], [ImagePath]) VALUES (N'C020', N'Images/Minuman dingin.png')
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M001', N'Cajo', 30000, N'C001', N'A001', N'Ricebowl ayam dengan saus gurih manis dan taburan bawang crispy lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M002', N'Ayam Penyet', 30000, N'C001', N'A001', N'Ayam goreng penyet dengan sambal pedas khas dan nasi hangat nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M003', N'Ayam Salted Egg', 30000, N'C001', N'A001', N'Ayam crispy dengan saus salted egg creamy gurih dan aroma khas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M004', N'Ayam Geprek', 30000, N'C001', N'A001', N'Ayam crispy geprek dengan sambal pedas menggoda pecinta makanan pedas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M005', N'Ayam Asam Manis', 30000, N'C001', N'A001', N'Ayam goreng dengan saus asam manis segar berpadu rasa gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M006', N'Ayam Saus Tiram', 30000, N'C001', N'A001', N'Ayam tumis saus tiram dengan rasa gurih manis dan aroma bawang.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M007', N'Ayam Saus Pedas', 30000, N'C001', N'A001', N'Ayam dengan saus pedas manis kaya rasa cocok disantap bersama nasi.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M008', N'Ayam Rica', 30000, N'C001', N'A001', N'Ayam rica pedas khas Manado dengan rempah harum menggugah selera.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M009', N'Chicken Blackpepper', 30000, N'C001', N'A001', N'Ayam lada hitam dengan rasa gurih pedas dan aroma rempah khas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M010', N'Chicken Mayonaise', 30000, N'C001', N'A001', N'Ayam crispy dengan saus mayonaise creamy lembut dan gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M011', N'Sotong / Udang Blackpepper', 30000, N'C001', N'A001', N'Sotong atau udang dengan saus lada hitam gurih pedas menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M012', N'Sotong Salted Egg', 30000, N'C001', N'A001', N'Sotong crispy dengan saus salted egg creamy gurih dan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M013', N'Sotong Mayonaise', 30000, N'C001', N'A001', N'Sotong crispy dengan balutan mayonaise creamy lembut dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M014', N'Udang Mayonaise', 30000, N'C001', N'A001', N'Udang goreng crispy dengan saus mayonaise creamy gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M015', N'Udang Salted Egg', 30000, N'C001', N'A001', N'Udang crispy dengan saus salted egg creamy dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M016', N'Bihun Kuah Seafood', 28000, N'C002', N'A001', N'Bihun kuah hangat dengan seafood segar dan kaldu gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M017', N'Bihun Kuah Ayam', 28000, N'C002', N'A001', N'Bihun kuah ayam dengan rasa gurih hangat cocok kapan saja.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M018', N'Bihun Siram Seafood', 28000, N'C002', N'A001', N'Bihun siram seafood dengan saus kental gurih dan topping lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M019', N'Bihun Siram Ayam', 28000, N'C002', N'A001', N'Bihun siram ayam dengan kuah kental gurih dan mengenyangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M020', N'Bihun Goreng Seafood', 28000, N'C002', N'A001', N'Bihun goreng seafood dengan aroma smoky dan bumbu gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M021', N'Bihun Goreng Ayam', 28000, N'C002', N'A001', N'Bihun goreng ayam berbumbu spesial dengan rasa gurih manis.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M022', N'Nasi Goreng Seafood', 28000, N'C003', N'A001', N'Nasi goreng seafood dengan topping seafood segar melimpah lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M023', N'Nasi Goreng Ayam', 28000, N'C003', N'A001', N'Nasi goreng ayam dengan bumbu spesial dan rasa gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M024', N'Nasi Goreng Kampung', 28000, N'C003', N'A001', N'Nasi goreng kampung dengan cita rasa tradisional pedas gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M025', N'Nasi Goreng Cabe Hijau', 28000, N'C003', N'A001', N'Nasi goreng cabe hijau dengan rasa pedas segar menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M026', N'Nasi Goreng Bilis', 28000, N'C003', N'A001', N'Nasi goreng bilis dengan ikan teri gurih dan rasa khas lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M027', N'Nasi Goreng Polos', 28000, N'C003', N'A001', N'Nasi goreng sederhana dengan bumbu gurih ringan dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M028', N'Nasi Putih', 5000, N'C003', N'A001', N'Nasi putih hangat pulen cocok disantap dengan berbagai lauk.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M029', N'Mie Kuah Seafood', 28000, N'C004', N'A001', N'Mie kuah seafood dengan kaldu gurih hangat dan seafood segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M030', N'Mie Kuah Ayam', 28000, N'C004', N'A001', N'Mie kuah ayam dengan rasa gurih hangat pas segala suasana.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M031', N'Mie Siram Ayam', 28000, N'C004', N'A001', N'Mie siram ayam dengan saus kental gurih dan topping lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M032', N'Mie Siram Seafood', 28000, N'C004', N'A001', N'Mie siram seafood dengan kuah kental gurih dan seafood segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M033', N'Mie Goreng Seafood', 28000, N'C004', N'A001', N'Mie goreng seafood berbumbu spesial dengan aroma smoky lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M034', N'Mie Goreng Ayam', 28000, N'C004', N'A001', N'Mie goreng ayam dengan rasa gurih manis dan topping ayam.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M035', N'Hokian Mie', 28000, N'C004', N'A001', N'Hokian mie khas dengan tekstur kenyal dan bumbu autentik.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M036', N'Kwetiau Kuah Seafood', 28000, N'C005', N'A001', N'Kwetiau kuah seafood dengan kaldu gurih dan seafood segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M037', N'Kwetiau Kuah Ayam', 28000, N'C005', N'A001', N'Kwetiau kuah ayam dengan rasa gurih hangat dan lembut.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M038', N'Kwetiau Siram Seafood', 28000, N'C005', N'A001', N'Kwetiau siram seafood dengan saus kental dan topping lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M039', N'Kwetiau Siram Ayam', 28000, N'C005', N'A001', N'Kwetiau siram ayam dengan kuah gurih lezat dan mengenyangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M040', N'Kwetiau Goreng Seafood', 28000, N'C005', N'A001', N'Kwetiau goreng seafood dengan aroma smoky dan bumbu gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M041', N'Kwetiau Goreng Ayam', 28000, N'C005', N'A001', N'Kwetiau goreng ayam berbumbu spesial dengan rasa nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M042', N'Indomie Goreng', 15000, N'C006', N'A001', N'Indomie goreng favorit dengan bumbu khas gurih manis lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M043', N'Indomie Goreng Seafood', 18000, N'C006', N'A001', N'Indomie goreng seafood dengan topping seafood segar nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M044', N'Indomie Goreng Jumbo', 18000, N'C006', N'A001', N'Porsi jumbo indomie goreng yang lebih mengenyangkan dan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M045', N'Indomie Goreng Jumbo Seafood', 21000, N'C006', N'A001', N'Indomie goreng jumbo seafood dengan topping melimpah lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M046', N'Indomie Goreng Vege', 18000, N'C006', N'A001', N'Indomie goreng sayur dengan rasa gurih ringan dan segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M047', N'Indomie Goreng Jumbo Vege', 21000, N'C006', N'A001', N'Indomie goreng jumbo sayur dengan porsi besar dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M048', N'Indomie Kuah', 15000, N'C006', N'A001', N'Indomie kuah hangat dengan kaldu gurih cocok kapan saja.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M049', N'Indomie Kuah Seafood', 18000, N'C006', N'A001', N'Indomie kuah seafood dengan rasa gurih dan seafood segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M050', N'Indomie Kuah Jumbo', 18000, N'C006', N'A001', N'Indomie kuah jumbo dengan porsi besar dan kuah nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M051', N'Indomie Kuah Jumbo Seafood', 21000, N'C006', N'A001', N'Indomie kuah jumbo seafood dengan topping melimpah lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M052', N'Indomie Kuah Vege', 18000, N'C006', N'A001', N'Indomie kuah sayur dengan rasa hangat gurih dan segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M053', N'Indomie Kuah Jumbo Vege', 21000, N'C006', N'A001', N'Indomie kuah jumbo sayur dengan porsi besar dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M054', N'Sagu Mie Kering', 28000, N'C007', N'A001', N'Sagu mie kering khas dengan tekstur unik dan rasa gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M055', N'Sagu Lembab', 28000, N'C007', N'A001', N'Sagu mie lembab dengan bumbu gurih khas dan tekstur lembut.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M056', N'Sagu Basah', 28000, N'C007', N'A001', N'Sagu mie basah dengan rasa gurih autentik dan kenyal lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M057', N'Ayam Goreng Bawang', 45000, N'C008', N'A001', N'Ayam goreng bawang crispy dengan aroma bawang harum gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M058', N'Ayam Salted Egg', 40000, N'C008', N'A001', N'Ayam crispy dengan saus salted egg creamy gurih dan aroma khas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M059', N'Ayam Blackpepper', 40000, N'C008', N'A001', N'Ayam lada hitam dengan rasa pedas gurih dan aroma rempah.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M060', N'Ayam Rica Tondano', 30000, N'C008', N'A001', N'Ayam rica khas Tondano dengan rempah pedas harum autentik.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M061', N'Ayam Asam Manis', 30000, N'C008', N'A001', N'Ayam goreng dengan saus asam manis segar berpadu rasa gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M062', N'Ayam Saus Pedas', 30000, N'C008', N'A001', N'Ayam dengan saus pedas manis kaya rasa cocok disantap bersama nasi.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M063', N'Ayam Geprek', 28000, N'C008', N'A001', N'Ayam crispy geprek dengan sambal pedas menggoda pecinta makanan pedas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M064', N'Ayam Sambal Mentah', 23000, N'C008', N'A001', N'Ayam goreng dengan sambal mentah segar pedas dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M065', N'Ayam Cabe Hijau', 23000, N'C008', N'A001', N'Ayam cabe hijau dengan rasa pedas segar dan gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M066', N'Ayam Penyet', 23000, N'C008', N'A001', N'Ayam goreng penyet dengan sambal pedas khas dan nasi hangat nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M067', N'lele Penyet', 23000, N'C009', N'A001', N'Lele goreng penyet dengan sambal pedas khas dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M068', N'lele Cabe Hijau', 23000, N'C009', N'A001', N'Lele dengan cabe hijau pedas segar dan aroma menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M069', N'lele Sambal Mentah', 23000, N'C009', N'A001', N'Lele goreng dengan sambal mentah segar pedas dan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M070', N'Selar Cabe Hijau', 30000, N'C010', N'A001', N'Ikan selar dengan cabe hijau pedas segar dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M071', N'Selar Sambal Mentah', 30000, N'C010', N'A001', N'Ikan selar goreng dengan sambal mentah segar dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M072', N'Selar Penyet', 30000, N'C010', N'A001', N'Ikan selar penyet dengan sambal khas pedas dan renyah.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M073', N'Dori Salted Egg', 50000, N'C011', N'A001', N'Ikan dori crispy dengan saus salted egg creamy gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M074', N'Dori Asam Manis', 30000, N'C011', N'A001', N'Ikan dori dengan saus asam manis segar dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M075', N'Dori Cabe Hijau', 30000, N'C011', N'A001', N'Ikan dori cabe hijau dengan rasa pedas segar menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M076', N'Dori Cabe Geprek', 30000, N'C011', N'A001', N'Ikan dori geprek dengan sambal pedas dan crispy nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M077', N'Udang Salted Egg', 50000, N'C012', N'A001', N'Udang crispy dengan saus salted egg creamy dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M078', N'Udang Blackpepper', 50000, N'C012', N'A001', N'Udang lada hitam dengan aroma rempah dan rasa gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M079', N'Udang Asam Pedas', 40000, N'C012', N'A001', N'Udang dengan kuah asam pedas segar menggugah selera.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M080', N'Udang Geprek', 35000, N'C012', N'A001', N'Udang crispy geprek dengan sambal pedas favorit seafood.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M081', N'Udang Rica Tondano', 30000, N'C012', N'A001', N'Udang rica khas Tondano dengan bumbu pedas autentik.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M082', N'Udang Goreng Tepung', 30000, N'C012', N'A001', N'Udang goreng tepung crispy dengan tekstur renyah gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M083', N'Udang Mayonaise', 30000, N'C012', N'A001', N'Udang goreng crispy dengan saus mayonaise creamy gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M084', N'Udang Saus Pedas', 30000, N'C012', N'A001', N'Udang dengan saus pedas manis kaya rasa menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M085', N'Udang Asam Manis', 30000, N'C012', N'A001', N'Udang dengan saus asam manis segar dan gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M086', N'Udang Cabe Ijo', 30000, N'C012', N'A001', N'Udang cabe ijo dengan rasa pedas segar dan gurih lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M087', N'Sotong Salted Egg', 50000, N'C013', N'A001', N'Sotong crispy dengan saus salted egg creamy gurih dan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M088', N'Sotong Blackpepper', 50000, N'C013', N'A001', N'Sotong lada hitam dengan aroma rempah dan gurih pedas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M089', N'Sotong Asam Pedas', 40000, N'C013', N'A001', N'Sotong dengan kuah asam pedas segar menggugah selera.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M090', N'Sotong Geprek', 35000, N'C013', N'A001', N'Sotong crispy geprek dengan sambal pedas favorit seafood.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M091', N'Sotong Rica Tondano', 30000, N'C013', N'A001', N'Sotong rica khas Tondano dengan bumbu pedas autentik.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M092', N'Sotong Goreng Tepung', 30000, N'C013', N'A001', N'Sotong goreng tepung crispy dengan tekstur renyah gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M093', N'Sotong Asam Manis', 30000, N'C013', N'A001', N'Sotong dengan saus asam manis segar dan gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M094', N'Sotong Saus Pedas', 30000, N'C013', N'A001', N'Sotong saus pedas dengan rasa gurih pedas dan aroma menggugah selera.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M095', N'Sotong Cabe Hijau', 30000, N'C013', N'A001', N'Sotong cabe hijau dengan rasa pedas segar dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M096', N'Kangkung Trasi', 23000, N'C014', N'A001', N'Kangkung tumis trasi dengan aroma khas dan gurih pedas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M097', N'Kangkung Polos', 23000, N'C014', N'A001', N'Kangkung tumis sederhana dengan rasa segar gurih renyah.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M098', N'Cap Cay', 23000, N'C014', N'A001', N'Cap cay sayuran segar dengan kuah gurih dan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M099', N'Baby Kailan Polos', 23000, N'C014', N'A001', N'Baby kailan tumis polos dengan rasa segar dan renyah.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M100', N'Baby Kailan Trasi', 23000, N'C014', N'A001', N'Baby kailan tumis trasi dengan aroma khas dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M101', N'Tauge Ikan Asin', 23000, N'C014', N'A001', N'Tauge tumis ikan asin dengan rasa gurih khas menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M102', N'Timun Telur', 23000, N'C014', N'A001', N'Timun telur segar dengan rasa gurih ringan dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M103', N'Sapo Tahu', 28000, N'C014', N'A001', N'Sapo tahu hangat dengan kuah gurih dan isian lengkap.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M104', N'Enoki Salted Egg', 30000, N'C014', N'A001', N'Jamur enoki dengan saus salted egg creamy gurih unik.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M105', N'Soup Timun', 25000, N'C015', N'A001', N'Soup timun hangat dengan rasa segar gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M106', N'Soup Bakso', 25000, N'C015', N'A001', N'Soup bakso dengan kuah gurih hangat dan bakso kenyal.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M107', N'Soup Seafood', 35000, N'C015', N'A001', N'Soup seafood dengan kaldu gurih dan seafood segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M108', N'Tom Yam', 40000, N'C015', N'A001', N'Tom yam khas Thailand dengan rasa asam pedas segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M109', N'French Fries', 15000, N'C016', N'A001', N'Kentang goreng crispy dengan tekstur renyah dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M110', N'Sosis', 15000, N'C016', N'A001', N'Sosis goreng dengan rasa gurih lezat untuk camilan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M111', N'Chicken Wings', 25000, N'C016', N'A001', N'Sayap ayam crispy berbumbu gurih pedas cocok berbagi.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M112', N'Nugget', 23000, N'C016', N'A001', N'Nugget ayam crispy dengan tekstur lembut dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M113', N'Onion Ring', 15000, N'C016', N'A001', N'Onion ring crispy dengan tekstur renyah dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M114', N'Chicken Strips', 23000, N'C016', N'A001', N'Potongan ayam crispy dengan bumbu gurih dan renyah.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M115', N'D2 Mini Platter', 30000, N'C016', N'A001', N'Paket camilan mini dengan aneka gorengan lezat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M116', N'D2 Maxi Platter', 40000, N'C016', N'A001', N'Paket camilan lengkap dengan porsi besar dan favorit.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M117', N'Chicken Skin', 45000, N'C016', N'A001', N'Kulit ayam crispy dengan rasa gurih renyah favorit.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M118', N'Telur Dadar', 8000, N'C016', N'A001', N'Telur dadar gurih lembut cocok sebagai lauk tambahan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M119', N'Telur Mata Sapi', 8000, N'C016', N'A001', N'Telur mata sapi dengan kuning telur lembut dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M120', N'Telur Rebus', 8000, N'C016', N'A001', N'Telur rebus sederhana sehat sebagai tambahan menu.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M121', N'Telur Crispy', 10000, N'C016', N'A001', N'Telur crispy dengan tekstur renyah unik dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M122', N'Telur Bombay', 12000, N'C016', N'A001', N'Telur bombay dengan tumisan bawang gurih menggoda.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M123', N'Telur Tomat', 15000, N'C016', N'A001', N'Telur tumis tomat dengan rasa segar gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M124', N'3T (Tahu, Telur, Tempe)', 18000, N'C016', N'A001', N'Kombinasi tahu telur tempe goreng gurih pelengkap.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M125', N'Tahu Goreng', 15000, N'C016', N'A001', N'Tahu goreng crispy dengan tekstur lembut dan gurih.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M126', N'Tempe Goreng', 15000, N'C016', N'A001', N'Tempe goreng gurih renyah dengan cita rasa khas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M127', N'Tahu Tempe Goreng', 15000, N'C016', N'A001', N'Kombinasi tahu dan tempe goreng gurih pelengkap.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M128', N'Teh O', 5000, N'C017', N'A001', N'Teh hangat manis dengan aroma teh klasik yang cocok dinikmati santai.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M129', N'Teh Tawar', 5000, N'C017', N'A001', N'Es teh tawar dingin dengan rasa ringan dan segar alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M130', N'Teh Susu', 10000, N'C017', N'A001', N'Es teh susu creamy dingin dengan rasa manis menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M131', N'Teh Tarik', 10000, N'C017', N'A001', N'Es teh tarik creamy dingin dengan busa lembut yang nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M132', N'Kopi O', 8000, N'C017', N'A001', N'Kopi hitam hangat dengan aroma khas dan rasa kuat menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M133', N'Kopi Kosong', 8000, N'C017', N'A001', N'Es kopi hitam tanpa gula dengan rasa pahit autentik dingin.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M134', N'Kopi Susu', 12000, N'C017', N'A001', N'Es kopi susu creamy dingin dengan rasa manis gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M135', N'Milo', 10000, N'C017', N'A001', N'Es milo dingin creamy coklat manis favorit segala usia.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M136', N'Jeruk Manis', 6000, N'C017', N'A001', N'Jeruk manis dingin segar dengan rasa buah alami nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M137', N'Jeruk Peras', 10000, N'C017', N'A001', N'Jeruk peras dingin segar dengan rasa asam manis alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M138', N'Jeruk Nipis', 6000, N'C017', N'A001', N'Jeruk nipis hangat dengan rasa segar dan aroma citrus alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M139', N'Lemon Tea', 6000, N'C017', N'A001', N'Es lemon tea segar dengan rasa manis asam menyenangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M140', N'Matcha Panas', 12000, N'C017', N'A001', N'Matcha panas creamy dengan aroma teh hijau khas Jepang.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M141', N'Thai Tea', 12000, N'C017', N'A001', N'Thai tea dingin creamy dengan rasa manis khas menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M142', N'Sprite', 10000, N'C018', N'A001', N'Minuman soda lemon segar dengan sensasi dingin menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M143', N'Fanta', 10000, N'C018', N'A001', N'Minuman soda manis berkarbonasi dengan rasa buah menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M144', N'Coca Cola', 10000, N'C018', N'A001', N'Minuman cola berkarbonasi dengan rasa khas yang menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M145', N'A&W Sarsaparila', 10000, N'C018', N'A001', N'Minuman sarsaparila dingin dengan rasa khas dan menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M146', N'Teh Bunga', 10000, N'C018', N'A001', N'Minuman teh bunga dengan aroma harum dan rasa ringan segar.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M147', N'Lasegar', 10000, N'C018', N'A001', N'Minuman penyegar dengan sensasi dingin dan rasa menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M148', N'Pocari Sweat', 10000, N'C018', N'A001', N'Minuman isotonik segar untuk membantu mengganti cairan tubuh.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M149', N'You C 1000', 10000, N'C018', N'A001', N'Minuman vitamin C segar dengan rasa buah yang menyenangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M150', N'Air Mineral', 5000, N'C018', N'A001', N'Air mineral segar dan murni cocok menemani segala hidangan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M151', N'Jus Alpukat', 20000, N'C019', N'A001', N'Jus alpukat creamy segar dengan tekstur lembut dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M152', N'Jus Sirsak', 18000, N'C019', N'A001', N'Jus sirsak segar dengan rasa manis asam alami menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M153', N'Jus Buah Naga', 18000, N'C019', N'A001', N'Jus buah naga segar dengan rasa manis lembut dan sehat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M154', N'Jus Mangga', 18000, N'C019', N'A001', N'Jus mangga segar dengan rasa manis tropis yang nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M155', N'Jus Jeruk', 18000, N'C019', N'A001', N'Jus jeruk segar dengan rasa asam manis kaya vitamin alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M156', N'Jus Tomat', 18000, N'C019', N'A001', N'Jus tomat segar dengan rasa alami dan kaya nutrisi sehat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M157', N'Jus Wortel', 18000, N'C019', N'A001', N'Jus wortel segar kaya vitamin dengan rasa manis alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M158', N'Jus Nenas', 18000, N'C019', N'A001', N'Jus nenas segar dengan rasa asam manis tropis menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M159', N'Jus Strawberry', 18000, N'C019', N'A001', N'Jus strawberry segar dengan rasa manis asam yang nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M160', N'Teh Obeng', 7000, N'C020', N'A001', N'Es teh manis dingin menyegarkan cocok dinikmati saat panas.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M161', N'Teh Tawar', 7000, N'C020', N'A001', N'Es teh tawar dingin dengan rasa ringan dan segar alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M162', N'Teh Susu', 12000, N'C020', N'A001', N'Es teh susu creamy dingin dengan rasa manis menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M163', N'Teh Tarik', 12000, N'C020', N'A001', N'Es teh tarik creamy dingin dengan busa lembut yang nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M164', N'Lemon Tea', 10000, N'C020', N'A001', N'Es lemon tea segar dengan rasa manis asam menyenangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M165', N'Kopi Obeng', 10000, N'C020', N'A001', N'Es kopi manis dingin dengan aroma kopi khas menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M166', N'Kopi Kosong', 10000, N'C020', N'A001', N'Es kopi hitam tanpa gula dengan rasa pahit autentik dingin.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M167', N'Kopi Susu', 14000, N'C020', N'A001', N'Es kopi susu creamy dingin dengan rasa manis gurih nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M168', N'Milo', 15000, N'C020', N'A001', N'Es milo dingin creamy coklat manis favorit segala usia.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M169', N'Es Kosong', 2000, N'C020', N'A001', N'Es batu segar cocok sebagai tambahan berbagai minuman dingin.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M170', N'Semboi', 8000, N'C020', N'A001', N'Minuman semboi segar dengan rasa manis asam menyenangkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M171', N'Markisa', 8000, N'C020', N'A001', N'Minuman markisa segar dengan aroma buah tropis khas nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M172', N'Lemon', 8000, N'C020', N'A001', N'Minuman lemon segar dengan rasa asam manis menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M173', N'Rosella', 8000, N'C020', N'A001', N'Minuman rosella segar dengan rasa khas dan aroma bunga.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M174', N'Jeruk Manis', 8000, N'C020', N'A001', N'Jeruk manis dingin segar dengan rasa buah alami nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M175', N'Jeruk Peras', 12000, N'C020', N'A001', N'Jeruk peras dingin segar dengan rasa asam manis alami.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M176', N'Matcha Dingin', 15000, N'C020', N'A001', N'Matcha dingin creamy dengan aroma teh hijau khas Jepang.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M177', N'Thai Tea', 15000, N'C020', N'A001', N'Thai tea dingin creamy dengan rasa manis khas menyegarkan.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M178', N'Es Longan', 15000, N'C020', N'A001', N'Es longan segar dengan buah longan manis dan es dingin.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
INSERT [dbo].[MENU] ([MenuID], [MenuName], [Price], [CatID], [MenAddedBy], [ShortDesc], [CreatedAt]) VALUES (N'M179', N'Es Koteng', 15000, N'C020', N'A001', N'Es koteng segar dengan campuran khas manis dan nikmat.', CAST(N'2026-06-01T13:25:31.307' AS DateTime))
GO
ALTER TABLE [dbo].[ADMIN] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[MENU] ADD  DEFAULT ('UNKN') FOR [CatID]
GO
ALTER TABLE [dbo].[MENU] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CATEGORY_IMAGE]  WITH CHECK ADD  CONSTRAINT [CATIMGFK] FOREIGN KEY([Cat_ID])
REFERENCES [dbo].[CATEGORY] ([CategoryID])
GO
ALTER TABLE [dbo].[CATEGORY_IMAGE] CHECK CONSTRAINT [CATIMGFK]
GO
ALTER TABLE [dbo].[MENU]  WITH CHECK ADD  CONSTRAINT [CATFK] FOREIGN KEY([CatID])
REFERENCES [dbo].[CATEGORY] ([CategoryID])
ON UPDATE CASCADE
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[MENU] CHECK CONSTRAINT [CATFK]
GO
USE [master]
GO
ALTER DATABASE [DOUBLE2CAFE] SET  READ_WRITE 
GO
