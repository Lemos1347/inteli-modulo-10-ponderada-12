-- Habilita a extensão pgcrypto, necessária para gerar UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Criação do tipo enum para o status da task
CREATE TYPE task_status AS ENUM ('pending', 'done');

-- Criação do tipo enum para o role do usuário
CREATE TYPE user_role AS ENUM ('user', 'admin');

-- Criação da tabela User
CREATE TABLE "User" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    role user_role NOT NULL
);

-- Criação da tabela Task
CREATE TABLE "Task" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    text TEXT NOT NULL,
    status task_status NOT NULL,
    user_id UUID NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User" (id)
);

INSERT INTO "User" (id, name, role)
VALUES ('03fd5486-2030-47cf-bf14-0e569d64fad9', 'Murilo', 'admin');

