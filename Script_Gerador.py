from faker import Faker
import pyodbc

fake = Faker('pt_PT')

# Configuração da conexão com o banco de dados SQL Server
conexao_str = (
    r'Driver={ODBC Driver 17 for SQL Server};'
    r'Server=CAPA;'
    r'Database=EscolaDomDinis;'
    r'Trusted_Connection=yes;'
    )
conexao = pyodbc.connect(conexao_str)

# Criação de um cursor
cursor = conexao.cursor()


# Número de registros a serem inseridos
numAlunos = 1000
numProfessores = 10
numCursos = 100
numDisciplinas = 50
numInscricoes = 1000
numNotas = 1000
# Inserção de dados na tabela Aluno
for _ in range(numAlunos):
    try:
        nome = fake.name()
        dataNascimento = fake.date()
        morada = fake.address()[:50]
        contacto =  fake.random_int(min=100000000, max=999999999)
        email = f"{nome.lower().replace(' ', '_')}@stu.ipbeja.com"
        query = f"INSERT INTO Aluno (nome, dataNascimento, morada,contacto,email) VALUES ('{nome}', '{dataNascimento}', '{morada}','{contacto}','{email}')"
        cursor.execute(query)
    except pyodbc.Error as e:
        print(f"Error inserting record: {e}")
    finally:
        conexao.commit()  
    
# Inserção de dados na tabela Professor
for _ in range(numProfessores):
    try:
        nome = fake.name()
        dataNascimento = fake.date()
        morada = fake.address()[:50]
        contacto =  fake.random_int(min=100000000, max=999999999)
        email = f"{nome.lower().replace(' ', '_')}@ipbeja.com"
        query = f"INSERT INTO Professor (nome, dataNascimento, morada,contacto,email) VALUES ('{nome}', '{dataNascimento}', '{morada}','{contacto}','{email}')"
        cursor.execute(query)
    except pyodbc.Error as e:
        print(f"Error inserting record: {e}")
    finally:
        conexao.commit()  
         
# Inserção de dados na tabela Curso
for _ in range(numCursos):
    try:
        nome = fake.name()
        descricao = fake.text()[:50]
        query = f"INSERT INTO Curso (nome,descricao) VALUES ('{nome}', '{descricao}')"
        cursor.execute(query)
    except pyodbc.Error as e:
        print(f"Error inserting record: {e}")
    finally:
        conexao.commit()  
        
# Inserção de dados na tabela Disciplina
for _ in range(numDisciplinas):
    try:
        nome = fake.name()

        # Generate a valid idProfessor value
        idProfessor = fake.random_int(min=1, max=numProfessores)

        # Ensure that the generated idProfessor exists in the Professor table
        while True:
            cursor.execute(f"SELECT 1 FROM Professor WHERE idProfessor = {idProfessor}")
            if cursor.fetchone():
                break
            else:
                # If idProfessor doesn't exist, generate a new one
                idProfessor = fake.random_int(min=1, max=numProfessores)

        query = f"INSERT INTO Disciplina (nome, idProfessor) VALUES ('{nome}', {idProfessor})"
        cursor.execute(query)
        print(f"Disciplina inserted: {nome}")
    except pyodbc.Error as e:
        print(f"Error inserting record into Disciplina: {e}")
        
# Inserção de dados na tabela Disciplina
for _ in range(numDisciplinas):
    try:
        nome = fake.name()

        # Generate a valid idProfessor value
        idProfessor = fake.random_int(min=1, max=numProfessores)

        # Ensure that the generated idProfessor exists in the Professor table
        while True:
            cursor.execute(f"SELECT 1 FROM Professor WHERE idProfessor = {idProfessor}")
            if cursor.fetchone():
                break
            else:
                # If idProfessor doesn't exist, generate a new one
                idProfessor = fake.random_int(min=1, max=numProfessores)

        query = f"INSERT INTO Disciplina (nome, idProfessor) VALUES ('{nome}', {idProfessor})"
        cursor.execute(query)
    except pyodbc.Error as e:
        print(f"Error inserting record into Disciplina: {e}")
    finally:
        conexao.commit()  
        
# Inserção de dados na tabela Inscrição

for _ in range(numInscricoes):
     try:
        # Generate valid idAluno and idCurso values
        idAluno = fake.random_int(min=1, max=numAlunos)
        idCurso = fake.random_int(min=1, max=numCursos)
        dataInscricao = fake.date()
        # Ensure that the generated idAluno exists in the Aluno table
        while True:
            cursor.execute(f"SELECT 1 FROM Aluno WHERE idAluno = {idAluno}")
            if cursor.fetchone():
                break
            else:
                # If idAluno doesn't exist, generate a new one
                idAluno = fake.random_int(min=1, max=numAlunos)

        # Insert into Inscricao table
        query = f"INSERT INTO Inscricao (idAluno, idCurso,dataInscricao) VALUES ({idAluno}, {idCurso},{dataInscricao})"
        cursor.execute(query)
     except pyodbc.Error as e:
        print(f"Error inserting record into Inscricao: {e}")
     finally:
        conexao.commit()  


# Inserção de dados na tabela Nota

for _ in range(numNotas):
    try:
        idAluno = fake.random_int(min=1, max=numAlunos)
        idDisciplina = fake.random_int(min=1, max=numDisciplinas)
        nota = fake.random_int(min=0, max=20)
        query = f"INSERT INTO Nota (idAluno, idDisciplina, nota) VALUES ('{idAluno}', '{idDisciplina}', '{nota}')"
        cursor.execute(query)
    except pyodbc.Error as e:
        print(f"Error inserting record: {e}")
    finally:
        conexao.commit()  
        
# Commit das alterações
conexao.commit()
print('Dados gerados e inseridos em todas as tabelas.')
# Feche a conexão
conexao.close()


