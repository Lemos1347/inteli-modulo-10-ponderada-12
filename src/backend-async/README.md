# Inteli módulo 10 ponderada 1

_Instruções_

```
Pessoal nossa atividade ponderada vai ser a construção de uma API assíncrona de gerenciamento de tasks.

O que vocês devem entregar, em um repositório do Github:

Collections do Insomnia para testar a API
YAML do OpenAPI (Swagger) para documentar a API
Código fonte da API
Instruções para executar a API
Obrigatóriamente ela deve ser uma API de grau de maturidade 2, ou seja, ela deve ser capaz de fazer a autenticação do usuário e permitir que ele crie, leia, atualize e delete tarefas. Você podem utilizar o código fornecido como base.

```

## API de Gerenciamento de Tarefas

Esta é uma API Flask desenvolvida para gerenciar tarefas com autenticação de usuários e controle de uma to-do list.

> [!IMPORTANT]
> A to-do list está sendo administrada em memória! Ou seja, ao reiniciar a aplicação, todos os dados serão perdidos.

## Funcionamento

https://github.com/Lemos1347/inteli-modulo-10-ponderada-1/assets/99190347/759fc23f-732d-494d-8587-2ff60522be7d

## Instalação

> [!NOTE]
> Antes de iniciar, você precisará ter o Python, Git, Docker e docker-compose instalado em sua máquina.

Primeiro, clone este repositório e entre na pasta do projeto:

```bash
git clone https://github.com/Lemos1347/inteli-modulo-10-ponderada-1.git ; cd inteli-modulo-10-ponderada-1/src/backend-sync
```

Para rodar esta aplicação, você precisa instalar as dependências listadas no arquivo `requirements.txt`:

```bash
pip install -r requirements.txt
```

É necessário também rodar um banco de dados postgresql. Para isso, você pode navegar até a pasta [build](./build) e rodar o seguinte comando:

```bash
docker-compose up --build
```

E por fim, crie um arquivo `.env` na root da pasta [src/backend-sync](.) com as seguintes variáveis de ambiente (você pode encontrar um exemplo em [.env.template](./src/backend-sync/.env.template)):

```env
DATABASE_URL={your_database_url}
```

## Executando a API

Você pode [seguir as instruções já informadas](../../README.md/#como-rodar) para iniciar a API, ou rode o seguinte comando na root desse repositório:

```bash
python main.py
```

Agora você pode acessar a API em [http://localhost:3001](http://localhost:3001).

## Documentação da API

Após iniciar a API, você pode acessar a documentação da API via Swagger UI pelo seguinte URL: [http://localhost:3001/docs](http://localhost:3001/docs).

Acesse este link para interagir com a API através da interface Swagger, onde você pode testar os endpoints diretamente.

Você pode encontrar a documentação da API em OpenAPI (Swagger) no arquivo [swagger.yaml](./static/swagger.yml).

Caso você prefira, você pode importar o arquivo [Insomnia_collection.json](./static/Insomnia_collection.json) no Insomnia para testar a API.

## Endpoints

> [!NOTE]
> Caso você tenha rodado o docker-compose, já existe um usário cadastrado no banco de dados com o id: 03fd5486-2030-47cf-bf14-0e569d64fad9 com o role de 'admin'

A API consiste nos seguintes endpoints:

- `POST /create_user`: Cria um novo usuário (acesso restrito a administradores).
- `POST /create_task`: Permite a um usuário autenticado criar uma nova tarefa.
- `GET /tasks`: Retorna todas as tarefas do usuário autenticado.
- `PUT /update_task`: Atualiza o status de uma tarefa específica do usuário autenticado.
- `DELETE /delete_task`: Remove uma tarefa específica do usuário autenticado.

Cada endpoint requer que o usuário esteja autenticado e passe o seu id no header 'Authorization'. Alguns endpoints exigem que o usuário seja um administrador (nesse caso, apenas `/create_user`).

> [!NOTE]
> Essa API foi construída sem o argumento `threaded=False`, para que seja uma api assíncrona.

## Dockerização da API

Foi produzido um Dockerfile para a API, que pode ser encontrado na pasta [build](./build). Nele é possível verificar que puxamos a imagem base `python:3.10.14 ` e copiamos os arquivos necessários para rodar a aplicação.
