from faker import Faker
import pyodbc

fake = Faker()

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

# Defina o número de registros que você deseja gerar para cada tabela
num_alunos = 100
num_cursos = 10
num_turmas = 50
num_disciplinas = 10
num_docentes = 20
num_questionarios = 50
num_respostas = 200
num_avaliacoes = 150

# Insira dados aleatórios na tabela Curso
for _ in range(num_cursos):
   
    nome_curso = fake.job()
    numero_edicao = fake.random_int(min=1, max=num_cursos)  # ajuste conforme necessário

    query = f"INSERT INTO Curso (Nome, Numero_edicao) VALUES ('{nome_curso}', {numero_edicao})"
    cursor.execute(query)

    # Insira dados aleatórios na tabela Turma
for _ in range(num_turmas):
    CursoID = fake.random_int(min=1, max=num_cursos)
    query = f"INSERT INTO Turma (CursoID) VALUES ( {CursoID})"
    cursor.execute(query)

    # Insira dados aleatórios na tabela Disciplina
for _ in range(num_disciplinas):
   
    nome_disciplina = fake.name()
    CursoID = fake.random_int(min=1, max=num_cursos)
    query = f"INSERT INTO Disciplina (Nome_disciplina, CursoID) VALUES ('{nome_disciplina}', {CursoID})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Docente
for _ in range(num_docentes):
   
    nome_docente = fake.name()
    endereco_docente = fake.address()

    query = f"INSERT INTO Docente (Nome_docente, Endereço) VALUES ('{nome_docente}', '{endereco_docente}')"
    cursor.execute(query)


# Insira dados aleatórios na tabela Aluno
for _ in range(num_alunos):
    
    nome_aluno = fake.name()
    TurmaID = fake.random_int(min=1, max=num_turmas)
    email_aluno = fake.email()
    contato_aluno = 2

    query = f"INSERT INTO Aluno (TurmaID,Nome_aluno,Email,Contato) VALUES ({TurmaID},'{nome_aluno}', '{email_aluno}', '{contato_aluno}')"
    cursor.execute(query)








# Insira dados aleatórios na tabela Avaliacao
for _ in range(num_avaliacoes):
    AlunoID = fake.random_int(min=1, max=num_alunos)
    DisciplinaID = fake.random_int(min=1, max=num_disciplinas)
    nota_avaliacao = fake.random_int(min=1, max=10)

    query = f"INSERT INTO Avaliacao (AlunoID, DisciplinaID, Nota_avaliacao) VALUES ({AlunoID}, {DisciplinaID}, {nota_avaliacao})"
    cursor.execute(query)



# Insira dados aleatórios na tabela Questionario
for _ in range(num_questionarios):
    numero_pergunta = fake.random_int(min=1, max=10)
    perguntas = fake.text(max_nb_chars=255)
    DisciplinaID = fake.random_int(min=1, max=num_disciplinas)
    DocenteID = fake.random_int(min=1, max=num_docentes)

    query = f"INSERT INTO Questionario (Numero_pergunta, Perguntas, DisciplinaID, DocenteID) VALUES ({numero_pergunta}, '{perguntas}', {DisciplinaID}, {DocenteID})"
    cursor.execute(query)

    # Insira dados aleatórios na tabela Resposta
for _ in range(num_respostas):
    texto_resposta = fake.text(max_nb_chars=255)
    numero_aluno_resposta = fake.random_int(min=1, max=num_alunos)
    numero_questionario_resposta = fake.random_int(min=1, max=num_questionarios)

    query = f"INSERT INTO Resposta (Texto, AlunoID, QuestionarioID) VALUES ('{texto_resposta}', {numero_aluno_resposta}, {numero_questionario_resposta})"
    cursor.execute(query)

# Commit das alterações
conexao.commit()

# Feche a conexão
conexao.close()

print('Dados gerados e inseridos em todas as tabelas.')
