from faker import Faker
import pyodbc

fake = Faker()

# Configuração da conexão com o banco de dados SQL Server
conexao_str = 'DRIVER={SQL Server};SERVER=servidor_sql;DATABASE=EscolaDomDinis;UID=usuario;PWD=senha'
conexao = pyodbc.connect(conexao_str)

# Criação de um cursor
cursor = conexao.cursor()

# Defina o número de registros que você deseja gerar para cada tabela
num_alunos = 100
num_cursos = 10
num_turmas = 50
num_disciplinas = 20
num_docentes = 20
num_questionarios = 50
num_respostas = 200
num_avaliacoes = 150

# Insira dados aleatórios na tabela Curso
for _ in range(num_cursos):
    nome_curso = fake.job()
    numero_edicao = fake.random_int(min=1, max=5)  # ajuste conforme necessário

    query = f"INSERT INTO Curso (Nome, Numero_edicao) VALUES ('{nome_curso}', {numero_edicao})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Turma
for _ in range(num_turmas):
    numero_curso_turma = fake.random_int(min=1, max=num_cursos)
    
    query = f"INSERT INTO Turma (Numero_curso) VALUES ({numero_curso_turma})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Disciplina
for _ in range(num_disciplinas):
    nome_disciplina = fake.word()
    numero_curso_disciplina = fake.random_int(min=1, max=num_cursos)
    
    query = f"INSERT INTO Disciplina (Nome_disciplina, Numero_curso) VALUES ('{nome_disciplina}', {numero_curso_disciplina})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Docente
for _ in range(num_docentes):
    nome_docente = fake.name()
    endereco_docente = fake.address()

    query = f"INSERT INTO Docente (Nome_docente, Endereço) VALUES ('{nome_docente}', '{endereco_docente}')"
    cursor.execute(query)

# Insira dados aleatórios na tabela Aluno
for _ in range(num_alunos):
    numero_turma_aluno = fake.random_int(min=1, max=num_turmas)
    nome_aluno = fake.name()
    email_aluno = fake.email()
    contato_aluno = fake.phone_number()

    query = f"INSERT INTO Aluno (Numero_turma, Nome_aluno, Email, Contato) VALUES ({numero_turma_aluno}, '{nome_aluno}', '{email_aluno}', '{contato_aluno}')"
    cursor.execute(query)

# Insira dados aleatórios na tabela Questionario
for _ in range(num_questionarios):
    numero_pergunta = fake.random_int(min=1, max=10)
    perguntas = fake.text(max_nb_chars=255)
    numero_disciplina_questionario = fake.random_int(min=1, max=num_disciplinas)
    numero_docente_questionario = fake.random_int(min=1, max=num_docentes)

    query = f"INSERT INTO Questionario (Numero_pergunta, Perguntas, Numero_disciplina, Numero_docente) VALUES ({numero_pergunta}, '{perguntas}', {numero_disciplina_questionario}, {numero_docente_questionario})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Resposta
for _ in range(num_respostas):
    texto_resposta = fake.text(max_nb_chars=255)
    numero_aluno_resposta = fake.random_int(min=1, max=num_alunos)
    numero_questionario_resposta = fake.random_int(min=1, max=num_questionarios)

    query = f"INSERT INTO Resposta (Texto, Numero_aluno, Numero_questionario) VALUES ('{texto_resposta}', {numero_aluno_resposta}, {numero_questionario_resposta})"
    cursor.execute(query)

# Insira dados aleatórios na tabela Avaliacao
for _ in range(num_avaliacoes):
    numero_aluno_avaliacao = fake.random_int(min=1, max=num_alunos)
    numero_disciplina_avaliacao = fake.random_int(min=1, max=num_disciplinas)
    nota_avaliacao = fake.random_int(min=1, max=10)

    query = f"INSERT INTO Avaliacao (Numero_aluno, Numero_disciplina, Nota_avaliacao) VALUES ({numero_aluno_avaliacao}, {numero_disciplina_avaliacao}, {nota_avaliacao})"
    cursor.execute(query)

# Commit das alterações
conexao.commit()

# Feche a conexão
conexao.close()

print('Dados gerados e inseridos em todas as tabelas.')
