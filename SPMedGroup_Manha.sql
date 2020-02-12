CREATE DATABASE SPMedGroup_Manha;

USE SpMedGroup_Manha;


CREATE TABLE TipoUsuario (
	IdTipoUsuario INT PRIMARY KEY IDENTITY,
	TituloUsuario VARCHAR (50)
);


CREATE TABLE Usuario (
	IdUsuario INT PRIMARY KEY IDENTITY,
	IdTipoUsuario INT FOREIGN KEY REFERENCES TipoUsuario (IdTipoUsuario),
	NomeUsuario VARCHAR (255),
	SenhaUsuario VARCHAR (255),
	EmailUsuario VARCHAR (255)
);


CREATE TABLE StatusConsulta (
	IdStatusConsulta INT PRIMARY KEY IDENTITY,
	TituloStatusConsulta VARCHAR (100)
);


CREATE TABLE Especialidade (
	IdEspecialidade INT PRIMARY KEY IDENTITY,
	NomeEspecialidade VARCHAR (255)
);

CREATE TABLE Endereco (
	IdEndereco INT PRIMARY KEY IDENTITY,
	Rua VARCHAR (255),
	Cidade VARCHAR (255),
	Estado VARCHAR (255),
	NumeroResidencia VARCHAR (255)
);

CREATE TABLE Prontuario (
	IdProntuario INT PRIMARY KEY IDENTITY,
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	IdEndereco INT FOREIGN KEY REFERENCES Endereco(IdEndereco),
	NomeProntuario VARCHAR (255),
	DataNascimento DATETIME2,
	CPF VARCHAR (20),
	RG VARCHAR (25),
	Telefone VARCHAR (50)
);

CREATE TABLE Medico (
	IdMedico INT PRIMARY KEY IDENTITY,
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	IdEspecialidade INT FOREIGN KEY REFERENCES Especialidade(IdEspecialidade),
	IdClinica INT FOREIGN KEY REFERENCES Clinica(IdClinica),
	NomeMedico	VARCHAR (100)
);

CREATE TABLE Consulta (
	IdConsulta INT PRIMARY KEY IDENTITY,
	IdProntuario INT FOREIGN KEY REFERENCES Prontuario (IdProntuario),
	IdMedico INT FOREIGN KEY REFERENCES Medico (IDMedico),
	IdStatusConsulta INT FOREIGN KEY REFERENCES StatusConsulta (IdStatusConsulta),
	DataAgendamento DATETIME2
);

CREATE TABLE Clinica (
	IdClinica INT PRIMARY KEY IDENTITY,
	IdEndereco INT FOREIGN KEY REFERENCES Endereco (IdEndereco),
	TituloClinica VARCHAR (100),
	CNPJ VARCHAR (50),
	RazaoSocial VARCHAR (100),
	HorarioAbertura TIME (0) NOT NULL,
	HorarioFechamento TIME (0) NOT NULL
);

-----------------------------------------------------------------------

INSERT INTO TipoUsuario(TituloUsuario) 
VALUES ('Administrador'),('Médico'),('Comum');

INSERT INTO Usuario (IdTipoUsuario,NomeUsuario,SenhaUsuario,EmailUsuario)
VALUES (1,'Administrador','adm123','adm@gmail.com'),
	   (3,'João','JoaoMatheus','Mario@hotmail.com'),
	   (3,'Mario','Mario123','Mario@hotmail.com'),
	   (2,'Dr.Saulo','Saulinho123','Doctor@gmail.com'),
	   (1,'Adm2','admnistrador','mda@gmail.com'),
	   (2,'Dr.Carol','Carol123','Carolina@gmail.com');

INSERT INTO StatusConsulta (TituloStatusConsulta)
VALUES ('Cancelada'),('Agendada'),('Realizada');

INSERT INTO Especialidade (NomeEspecialidade)
VALUES ('Acupuntura'),('Anestesiologia'),
	   ('Angiologia'),('Cardiologia'),('Cardiovascular'),
	   ('Cirurgia da Mão'),('Cirurgia do Aparelho Digestivo'),('Cirurgia Geral'),
	   ('Cirurgia Pediátrica'),('Cirurgia Plástica'),('Cirurgia Torácica'),
	   ('Cirurgia Vascular'),('Dermatologia'),('Radioterapia'),('Urologia'),
	   ('Pediatria'),('Psiquiatria');

INSERT INTO Endereco (Rua,Cidade,Estado,NumeroResidencia)
VALUES ('Dolores','Indaia','Espirito Santo','210'),
	   ('Maria das Dores','Mogi das Cruzes','São Paulo','300'),
	   ('Av.Barão de Limeira','São Paulo','São Paulo','532');

INSERT INTO Prontuario (IdUsuario,IdEndereco,NomeProntuario,DataNascimento,CPF,RG,Telefone)
VALUES (2,2,'João','04/02/2000','11111111111','123456789','1122-3456'),
	   (3,1,'Mario','25/11/1999','22222222222','234567890','3366-7790');

INSERT INTO Medico (IdUsuario,IdEspecialidade,IdClinica,NomeMedico)
VALUES (4,14,1,'Doutor Saulo'),
	   (6,17,1,'Doutora Carol');

INSERT INTO Consulta (IdProntuario,IdMedico,IdStatusConsulta,DataAgendamento)
VALUES (1,2,2,'25/02/2020'),
	   (2,1,1,'03/02/2020'),
	   (1,1,3,'01/01/2020');

INSERT INTO Clinica (IdEndereco,TituloClinica,CNPJ,RazaoSocial,HorarioAbertura,HorarioFechamento)
VALUES (3,'Clinica Possarle','123456789','Sp Medical Group','08:00:00','17:00:00');

INSERT INTO Usuario (IdTipoUsuario,NomeUsuario,SenhaUsuario,EmailUsuario)
VALUES (1,'Ligia','123','ligia@gmail.com'),
	   (1,'Alexandre','123','alexandre@gmail.com'),
	   (1,'Fernando','123','fernando@gmail.com'),
	   (1,'Henrique','123','henrique@gmail.com'),
	   (1,'João','123','joao@hotmail.com'),
	   (1,'Bruno','123','bruno@gmail.com'),
	   (1,'Mariana','123','mariana@outlook.com');

----------------------------------------------
-----------------------------------------------
INSERT INTO Medico (IdClinica)
VALUES (1),(1);

DELETE FROM Medico 
WHERE IdMedico >= 3;

ALTER TABLE Medico 
ADD IdClinica INT FOREIGN KEY REFERENCES Clinica (IdClinica);

DELETE FROM Medico 
WHERE IdMedico >= 1;


--------------------------------------------------------

--CONSULTA
SELECT NomeProntuario,DataNascimento,CPF,RG,Telefone,NomeMedico,NomeEspecialidade,HorarioAbertura,HorarioFechamento 
FROM Prontuario 
INNER JOIN Consulta ON Consulta.idProntuario = Prontuario.IdProntuario
INNER JOIN Medico ON Consulta.IdMedico = Medico.IdMedico
INNER JOIN Especialidade ON Medico.IdEspecialidade = Especialidade.IdEspecialidade
INNER JOIN Clinica ON Medico.IdClinica = Clinica.IdClinica;

-------------------------------------------------------------
SELECT * FROM Clinica;
SELECT * FROM Usuario;
SELECT * FROM Especialidade;
SELECT * FROM Endereco;
SELECT * FROM StatusConsulta;
SELECT * FROM TipoUsuario;
SELECT * FROM Prontuario;
SELECT * FROM Medico;
SELECT * FROM Consulta;



DROP TABLE Endereco;
DROP TABLE StatusConsulta;
DROP TABLE Consulta;
DROP TABLE Medico;

