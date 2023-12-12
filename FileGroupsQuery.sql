
-- Criação dos filegroups
ALTER DATABASE EscolaDomDinis
ADD FILEGROUP Primario;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP Secundario1;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP Secundario2;

-- Adição de ficheiros às filegroups
ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'Primario1', FILENAME = 'C:\Primario1.ndf')
TO FILEGROUP Primario;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'Secundario1_1', FILENAME = 'D:\Secundario1_1.ndf'),
    (NAME = 'Secundario1_2', FILENAME = 'E:\Secundario1_2.ndf')
TO FILEGROUP Secundario1;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'Secundario2_1', FILENAME = 'F:\Secundario2_1.ndf'),
    (NAME = 'Secundario2_2', FILENAME = 'G:\Secundario2_2.ndf')
TO FILEGROUP Secundario2;

-- Mover tabelas para filegroups específicos
ALTER TABLE Escola.Curso
MOVE TO Primario;

ALTER TABLE Escola.Aluno
MOVE TO Secundario1;

ALTER TABLE Escola.Disciplina
MOVE TO Secundario2;