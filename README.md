# Inteli módulo 10 ponderada 2 - App Gerenciador de Tarefas

Este é um aplicativo de gerenciamento de tarefas desenvolvido em Flutter. O objetivo deste aplicativo é fornecer uma interface simples para gerenciar tarefas diárias.

## Tecnologias Utilizadas

- Flutter
- Dart
- Flutter Bloc para gerenciamento de estado

## Funcionalidades

- Listar todas as tarefas
- Adicionar uma nova tarefa
- Editar uma tarefa existente
- Deletar uma tarefa

### Funcionamento

https://github.com/Lemos1347/inteli-modulo-10-ponderada-2/assets/99190347/a52b8e7b-3e95-4e8f-82c9-170177b075e9

## Instalação

Para executar este projeto, você precisará ter o Flutter instalado em sua máquina. Para mais informações, veja a [documentação oficial do Flutter](https://flutter.dev/docs/get-started/install).

> [!NOTE]
> Esse projeto foi desenvolvido pensando em dispositivos mobile, por isso, é recomendado que você tenha um emulador ou um dispositivo físico para executar o aplicativo.

> [!IMPORTANT]
> Este projeto mobile para funcionar precisa que você mude o ip em que está rodando o backend, para isso vá até o arquivo [task_service.dart](./src/mobile/lib/services/task_service.dart) e mude a variável `baseUrl` em:  
> `final String baseUrl = 'http://192.168.15.46:3001';`
> para o ip que está rodando o backend.

1. Clone o repositório:

   ```bash
   git clone https://github.com/Lemos1347/inteli-modulo-10-ponderada-2.git
   cd inteli-modulo-10-ponderada-2
   ```

2. Instale as dependências:

   ```bash
   cd mobile
   flutter pub get
   ```

3. Execute o projeto:
   ```bash
   flutter run
   ```

## Estrutura de diretórios

Dentro da pasta `src` você encontrará os seguintes arquivos / diretórios importantes.

### [mobile](./src/mobile/)

Este diretório contém todo o código fonte do aplicativo Flutter, com o seguinte esquema de pastas:

- [lib/](./src/mobile/lib/): Contém o código fonte do projeto.
- [lib/models/](./src/mobile/lib/models/): Definições de modelos de dados.
- [lib/blocs/](./src/mobile/lib/blocs/): Lógica de negócios e gerenciamento de estado.
- [lib/screens/](./src/mobile/lib/screens/): Telas do aplicativo.
- [lib/services/](./src/mobile/lib/services/): Serviços para comunicação com APIs externas.

### [backend-async](./src/backend/)

Este diretório contém todo o código fonte do backend em python3. Dentro de seu diretório é possi1vel encontrar um [readme](./src/backend-async/README.md) com as suas instruções detalhadas.

### [database](./src/database/)

Este diretório contém todos os scripts SQLs para criação do banco de dados da aplicação.

### [docker-compose.yml](./src/docker-compose.yml)

Este arquivo contém a configuração do docker-compose para subir o banco de dados e o backend. Para rodá-lo, basta executar o comando:

```bash
docker-compose up
```

Pronto! Agora você tem um backend rodando em `localhost:3001`e um banco de dados postgres configurado!
