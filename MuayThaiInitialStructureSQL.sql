CREATE SCHEMA [Sec]
GO
CREATE SCHEMA [App]
GO
CREATE TABLE [App].[Roles](
	RolId INT IDENTITY(1,1),
	RolDescription VARCHAR(60) NOT NULL UNIQUE,
	CONSTRAINT PK_App_Roles_Id PRIMARY KEY (RolId)
)
GO
CREATE TABLE [App].[MenuItems](
	MenuItemId INT IDENTITY(1,1),
	RolId INT NOT NULL,
	Title VARCHAR(50) NOT NULL UNIQUE,
	IconSource VARCHAR(100) NULL,
	TargetPage VARCHAR(150) NOT NULL UNIQUE, 
	CONSTRAINT PK_App_Roles_Id PRIMARY KEY (MenuItemId),
	CONSTRAINT FK_App_Roles_RolId FOREIGN KEY (RolId) REFERENCES [App].[Roles](RolId)
)
GO
CREATE TABLE [Sec].[Users](
	UserId INT IDENTITY(1,1),
	UserName VARCHAR(50) NOT NULL UNIQUE,
	[Password] VARCHAR(MAX) NOT NULL,
	RolId INT NOT NULL,
	CreatedDate DATETIME NOT NULL DEFAULT (GETUTCDATE()),
	CONSTRAINT PK_Sec_Users_Id PRIMARY KEY (UserId),
	CONSTRAINT FK_Sec_Users_RolId FOREIGN KEY (RolId) REFERENCES [App].[Roles](RolId)
)
GO
CREATE TABLE [Sec].[PasswordsHistory](
	HistoryId BIGINT IDENTITY(1,1),
	UserId INT NOT NULL,
	[Password] VARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_Sec_PasswordsHistory_Id PRIMARY KEY (HistoryId),
	CONSTRAINT FK_Sec_PasswordsHistory_UserId FOREIGN KEY (UserId) REFERENCES [Sec].[Users](UserId)
)
GO
CREATE TABLE [dbo].[MetodosPago](
	MetodoId BIGINT IDENTITY(1,1),
	MetodoDesc VARCHAR(50) NOT NULL,
	CONSTRAINT PK_dbo_MetodosPago_Id PRIMARY KEY (MetodoId)
)
GO
INSERT INTO [dbo].[MetodosPago]
	(MetodoDesc)
VALUES
	('Transferencia'),
	('Efectivo')
GO
CREATE TABLE [dbo].[Personas](
	AfiliadoId INT IDENTITY(1,1),
	UserId INT NOT NULL,
	NombreAfiliado VARCHAR(150),
	FechaNacimiento DATE NOT NULL,
	CONSTRAINT PK_dbo_Afiliados_Id PRIMARY KEY (AfiliadoId),
	CONSTRAINT FK_dbo_Afiliados_UserId FOREIGN KEY (UserId) REFERENCES [Sec].[Users](UserId)
)
GO
CREATE TABLE [dbo].[Pagos](
	PagoId BIGINT IDENTITY(1,1),
	AfiliadoId INT NOT NULL,
    FechaPago DATETIME NOT NULL,
	Mensualidad BIT NOT NULL,
	DiasPagados INT,
    MetodoId BIGINT NOT NULL,
    EvidenciaUrl VARCHAR(MAX),
	CONSTRAINT PK_dbo_Pagos_Id PRIMARY KEY (PagoId),
	CONSTRAINT FK_dbo_Pagos_MetodoId FOREIGN KEY (MetodoId) REFERENCES [dbo].[MetodosPago](MetodoId),
	CONSTRAINT FK_dbo_Pagos_AfiliadoId FOREIGN KEY (AfiliadoId) REFERENCES [dbo].[Afiliados](AfiliadoId)
)
GO
CREATE TABLE [dbo].[ClasesTomadas](
	ClaseId BIGINT IDENTITY(1,1),
	PagoId BIGINT NOT NULL,
	FechaClase DATETIME NOT NULL,
	Validada BIT NOT NULL,
	CONSTRAINT PK_dbo_ClasesTomadas_Id PRIMARY KEY (ClaseId),
	CONSTRAINT FK_dbo_ClasesTomadas_PagoId FOREIGN KEY (PagoId) REFERENCES [dbo].[Pagos](PagoId)
)
GO