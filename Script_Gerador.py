from faker import Faker
import pyodbc

fake = Faker()

# Configuração da conexão com o banco de dados SQL Server
conn_str = (
    r'Driver=SQL Server;'
    r'Server=.\SQLEXPRESS;'
    r'Database=EscolaDomDinis;'
    r'Trusted_Connection=yes;'
    )
conexao = pyodbc.connect(conn_str)

# Criação de um cursor
cursor = conexao.cursor()

# Defina o número de alunos que você deseja gerar
num_alunos = 1000

# Insira dados aleatórios na tabela Aluno
for _ in range(num_alunos):
    numero_turma = fake.random_int(min=1, max=10)  # ajuste conforme necessário
    nome_aluno = fake.name()
    email = fake.email()
    contato = fake.phone_number()

    # Query de inserção
    query = f"INSERT INTO Aluno (Numero_turma, Nome_aluno, Email, Contato) VALUES ({numero_turma}, '{nome_aluno}', '{email}', '{contato}')"

    # Execute a query
    cursor.execute(query)

# Defina o número de docentes que você deseja gerar
num_docentes = 200

# Insira dados aleatórios na tabela Docente
for _ in range(num_docentes):
    nome_docente = fake.name()
    endereco = fake.address()

    # Query de inserção
    query = f"INSERT INTO Docente (Nome_docente, Endereço) VALUES ('{nome_docente}', '{endereco}')"

    # Execute a query
    cursor.execute(query)
    
num_questionarios = 500

# Insira dados aleatórios na tabela Questionario
for _ in range(num_questionarios):
    numero_pergunta = fake.random_int(min=1, max=10)  # ajuste conforme necessário
    perguntas = fake.text(max_nb_chars=255)
    numero_disciplina = fake.random_int(min=1, max=10)  # ajuste conforme necessário
    numero_docente = fake.random_int(min=1, max=20)  # ajuste conforme necessário

    # Query de inserção
    query = f"INSERT INTO Questionario (Numero_pergunta, Perguntas, Numero_disciplina, Numero_docente) VALUES ({numero_pergunta}, '{perguntas}', {numero_disciplina}, {numero_docente})"

    # Execute a query
    cursor.execute(query)
    
num_respostas = 500

# Insira dados aleatórios na tabela Resposta
for _ in range(num_respostas):
    texto_resposta = fake.text(max_nb_chars=255)
    numero_aluno = fake.random_int(min=1, max=100)  # ajuste conforme necessário
    numero_questionario = fake.random_int(min=1, max=50)  # ajuste conforme necessário

    # Query de inserção
    query = f"INSERT INTO Resposta (Texto, Numero_aluno, Numero_questionario) VALUES ('{texto_resposta}', {numero_aluno}, {numero_questionario})"

    # Execute a query
    cursor.execute(query)
    
# Defina o número de avaliações que você deseja gerar
num_avaliacoes = 1000

# Insira dados aleatórios na tabela Avaliacao
for _ in range(num_avaliacoes):
    numero_aluno_avaliacao = fake.random_int(min=1, max=100)  # ajuste conforme necessário
    numero_disciplina_avaliacao = fake.random_int(min=1, max=10)  # ajuste conforme necessário
    nota_avaliacao = fake.random_int(min=1, max=10)  # ajuste conforme necessário

    # Query de inserção
    query = f"INSERT INTO Avaliacao (Numero_aluno, Numero_disciplina, Nota_avaliacao) VALUES ({numero_aluno_avaliacao}, {numero_disciplina_avaliacao}, {nota_avaliacao})"

    # Execute a query
    cursor.execute(query)

# Commit das alterações
conexao.commit()

# Feche a conexão
conexao.close()

print(f'Dados gerados e inseridos na tabela Aluno.')
