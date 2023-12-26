


USE EscolaDomDinis;
go 

CREATE TABLE Curso (
 idCurso INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
);

CREATE TABLE Turma (
 idTurma INT PRIMARY KEY IDENTITY(1,1),
 idCurso INT,
 FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Disciplina (
    idDisciplina INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    idCurso INT FOREIGN KEY REFERENCES Curso(idCurso),
);


CREATE TABLE Aluno (
 idAluno INT PRIMARY KEY IDENTITY(1,1),
 idTurma INT,
 nome VARCHAR(100),
 email VARCHAR(100),
 contacto VARCHAR(20)
 FOREIGN KEY (idTurma) REFERENCES Turma(idTurma)
);

CREATE TABLE Docente (
 idDocente INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
 morada VARCHAR(100),
);


CREATE TABLE Questionario (
 idQuestionario INT PRIMARY KEY IDENTITY(1,1),
 pergunta VARCHAR(255),
 idDisciplina INT,
 idDocente INT,
 FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina),
 FOREIGN KEY (idDocente) REFERENCES Docente(idDocente)
);

CREATE TABLE Resposta (
 idResposta INT PRIMARY KEY IDENTITY(1,1),
 texto VARCHAR(255),
 idAluno INT,
 idQuestionario INT,
 FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
 FOREIGN KEY (idQuestionario) REFERENCES Questionario(idQuestionario)
);

CREATE TABLE Avaliacao (
 idAvaliacao INT PRIMARY KEY IDENTITY(1,1),
 idAluno INT,
 idDisciplina INT,
 nota INT,
 FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
 FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);

CREATE TABLE Escola.HistoricoInsercaoAluno (
    IdHistorico INT PRIMARY KEY IDENTITY(1,1), -- ID do registro histórico
    Nome VARCHAR(100),                         -- Nome do aluno inserido
    Contacto VARCHAR(20),                      -- Contacto do aluno inserido
    Email VARCHAR(100),                        -- Email do aluno inserido
    IdTurma INT,                               -- ID da turma do aluno inserido
    DataInsercao DATETIME                      -- Data e hora da inserção
);
