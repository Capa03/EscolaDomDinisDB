
USE EscolaDomDinis;
go 

CREATE TABLE Aluno (
 AlunoID INT PRIMARY KEY IDENTITY(1,1),
 TurmaID INT,
 Nome_aluno VARCHAR(100),
 Email VARCHAR(100),
 Contato VARCHAR(20),
FOREIGN KEY (TurmaID) REFERENCES Turma(TurmaID)
);

CREATE TABLE Curso (
 CursoID INT PRIMARY KEY IDENTITY(1,1),
 Nome VARCHAR(100),
 Numero_edicao INT
);

CREATE TABLE Turma (
 TurmaID INT PRIMARY KEY IDENTITY(1,1),
 CursoID INT,
 FOREIGN KEY (CursoID) REFERENCES Curso(CursoID)
);

CREATE TABLE Disciplina (
 DisciplinaID INT PRIMARY KEY IDENTITY(1,1),
 Nome_disciplina VARCHAR(100),
 CursoID INT,
 FOREIGN KEY (CursoID) REFERENCES Curso(CursoID)
);

CREATE TABLE Docente (
 DocenteID INT PRIMARY KEY IDENTITY(1,1),
 Nome_docente VARCHAR(100),
 Endereço VARCHAR(100)
);


CREATE TABLE Questionario (
 QuestionarioID INT PRIMARY KEY IDENTITY(1,1),
 PerguntaID INT,
 Perguntas VARCHAR(255),
 DisciplinaID INT,
 DocenteID INT,
 FOREIGN KEY (DisciplinaID) REFERENCES Disciplina(DisciplinaID),
 FOREIGN KEY (DocenteID) REFERENCES Docente(DocenteID)
);

CREATE TABLE Resposta (
 RespostaID INT PRIMARY KEY IDENTITY(1,1),
 Texto VARCHAR(255),
 AlunoID INT,
 QuestionarioID INT,
 FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
 FOREIGN KEY (QuestionarioID) REFERENCES Questionario(QuestionarioID)
);

CREATE TABLE Avaliacao (
 AvaliacaoID INT PRIMARY KEY IDENTITY(1,1),
 AlunoID INT,
 DisciplinaID INT,
 Nota_avaliacao INT,
 FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
 FOREIGN KEY (DisciplinaID) REFERENCES Disciplina(DisciplinaID)
);

