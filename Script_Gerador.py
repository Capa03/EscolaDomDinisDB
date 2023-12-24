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
numAvaliacoes = 1000
numTurmas = 10
numDocentes = 10
numQuestionarios = 1000
numRespostas = 1000

# Inserção de dados na tabela Curso
for _ in range(numCursos):
    try:
        nome = fake.name()
        
        query = f"INSERT INTO Escola.Curso (nome) VALUES ('{nome}')"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Curso: {e}")

# Inserção de dados na tabela Turma
for _ in range(numTurmas):
    try:
        idCurso = fake.random_int(min=1, max=numCursos)

        # Ensure that the generated idCurso exists in the Curso table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Curso WHERE idCurso = {idCurso}")
            if cursor.fetchone():
                break
            else:
                # If idCurso doesn't exist, generate a new one
                idCurso = fake.random_int(min=1, max=numCursos)

        query = f"INSERT INTO Escola.Turma (idCurso) VALUES ({idCurso})"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Turma: {e}")

# Inserção de dados na tabela Disciplina
for _ in range(numDisciplinas):
    try:
        nome = fake.name()

        # Generate a valid idCurso value
        idCurso = fake.random_int(min=1, max=numCursos)

        # Ensure that the generated idCurso exists in the Curso table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Curso WHERE idCurso = {idCurso}")
            if cursor.fetchone():
                break
            else:
                # If idCurso doesn't exist, generate a new one
                idCurso = fake.random_int(min=1, max=numCursos)

        query = f"INSERT INTO Escola.Disciplina (nome, idCurso) VALUES ('{nome}', {idCurso})"
        cursor.execute(query)
        conexao.commit()
        print(f"Disciplina inserted: {nome}")
    except pyodbc.Error as e:
        print(f"Error inserting record into Disciplina: {e}")


# Inserção de dados na tabela Aluno
for _ in range(numAlunos):
    try:
        idTurma = fake.random_int(min=1, max=numTurmas)
        
        # Ensure that the generated idTurma exists in the Turma table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Turma WHERE idTurma = {idTurma}")
            if cursor.fetchone():
                break
            else:
                # If idTurma doesn't exist, generate a new one
                idTurma = fake.random_int(min=1, max=numTurmas)

        nome = fake.name()
        contacto = fake.random_int(min=100000000, max=999999999)
        email = f"{nome.lower().replace(' ', '_')}@stu.ipbeja.com"
        query = f"INSERT INTO Escola.Aluno (idTurma, nome, contacto, email) VALUES ({idTurma}, '{nome}', '{contacto}', '{email}')"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Aluno: {e}")


# Inserção de dados na tabela Docente
for _ in range(numDocentes):
    try:
        nome = fake.name()
        morada = fake.address()
        query = f"INSERT INTO Escola.Docente (nome, morada) VALUES ('{nome}', '{morada}')"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Docente: {e}")

# Inserção de dados na tabela Questionario
for _ in range(numQuestionarios):
    try:
        pergunta = fake.word()[0:50]

        # Generate a valid idDisciplina value
        idDisciplina = fake.random_int(min=1, max=numDisciplinas)

        # Ensure that the generated idDisciplina exists in the Disciplina table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Disciplina WHERE idDisciplina = {idDisciplina}")
            if cursor.fetchone():
                break
            else:
                # If idDisciplina doesn't exist, generate a new one
                idDisciplina = fake.random_int(min=1, max=numDisciplinas)

        query = f"INSERT INTO Escola.Questionario (pergunta, idDisciplina) VALUES ('{pergunta}', {idDisciplina})"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Questionario: {e}")


# Inserção de dados na tabela Resposta
for _ in range(numRespostas):
    try:
        idQuestionario = fake.random_int(min=1, max=numQuestionarios)

        # Ensure that the generated idQuestionario exists in the Questionario table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Questionario WHERE idQuestionario = {idQuestionario}")
            if cursor.fetchone():
                break
            else:
                # If idQuestionario doesn't exist, generate a new one
                idQuestionario = fake.random_int(min=1, max=numQuestionarios)

        idAluno = fake.random_int(min=1, max=numAlunos)

        # Ensure that the generated idAluno exists in the Aluno table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Aluno WHERE idAluno = {idAluno}")
            if cursor.fetchone():
                break
            else:
                # If idAluno doesn't exist, generate a new one
                idAluno = fake.random_int(min=1, max=numAlunos)

        texto = fake.random_int(min=0, max=5)
        query = f"INSERT INTO Escola.Resposta (texto, idAluno, idQuestionario) VALUES ('{texto}', {idAluno}, {idQuestionario})"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Resposta: {e}")


# Inserção de dados na tabela Avaliacao
for _ in range(numAvaliacoes):
    try:
        idAluno = fake.random_int(min=1, max=numAlunos)

        # Ensure that the generated idAluno exists in the Aluno table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Aluno WHERE idAluno = {idAluno}")
            if cursor.fetchone():
                break
            else:
                # If idAluno doesn't exist, generate a new one
                idAluno = fake.random_int(min=1, max=numAlunos)

        # Generate a valid idDisciplina value
        idDisciplina = fake.random_int(min=1, max=numDisciplinas)

        # Ensure that the generated idDisciplina exists in the Disciplina table
        while True:
            cursor.execute(f"SELECT 1 FROM Escola.Disciplina WHERE idDisciplina = {idDisciplina}")
            if cursor.fetchone():
                break
            else:
                # If idDisciplina doesn't exist, generate a new one
                idDisciplina = fake.random_int(min=1, max=numDisciplinas)

        nota = fake.random_int(min=0, max=20)
        query = f"INSERT INTO Escola.Avaliacao (idAluno, idDisciplina, nota) VALUES ({idAluno}, {idDisciplina}, {nota})"
        cursor.execute(query)
        conexao.commit()
    except pyodbc.Error as e:
        print(f"Error inserting record into Avaliacao: {e}")

# Feche a conexão
conexao.close()

print('Dados gerados e inseridos em todas as tabelas.')
