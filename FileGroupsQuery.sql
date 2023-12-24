
-- Criação dos filegroups
ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP1;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP2;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP3;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP4;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP5;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP6;

-- Adição de ficheiros às filegroups
ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'Primario1', FILENAME = 'E:\FILEGROUP1.ndf')
TO FILEGROUP FILEGROUP1;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP2', FILENAME = 'F:\FILEGROUP2.ndf')
TO FILEGROUP FILEGROUP2;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP3', FILENAME = 'G:\FILEGROUP3.ndf')
TO FILEGROUP FILEGROUP3;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP4', FILENAME = 'H:\FILEGROUP4.ndf')
TO FILEGROUP FILEGROUP4;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP5', FILENAME = 'I:\FILEGROUP5.ndf')
TO FILEGROUP FILEGROUP5;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP6', FILENAME = 'J:\FILEGROUP6.ndf')
TO FILEGROUP FILEGROUP6;

-- Move the Curso table to FILEGROUP1
USE EscolaDomDinis;

-- Drop the existing clustered index (replace 'idCurso' with the actual name of your clustered index)
DROP INDEX idCurso ON Escola.Curso;

-- Rebuild the clustered index on the new filegroup
CREATE CLUSTERED INDEX idCurso
ON Escola.Curso (idCurso)  -- Replace 'YourPrimaryKeyColumn' with the actual primary key column
WITH (DROP_EXISTING = ON)
ON FILEGROUP1;  -- Replace 'FILEGROUP1' with the actual name of your filegroup
