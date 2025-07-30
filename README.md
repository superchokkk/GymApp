# GymApp 🏋️‍♂️

Aplicativo móvel para gerenciamento de academias desenvolvido em Flutter com backend em Node.js.

## 📱 Sobre o Projeto

O GymApp é uma solução completa para academias que permite o gerenciamento de alunos, funcionários e exercícios através de uma interface mobile moderna e intuitiva.

## 🚀 Tecnologias Utilizadas

### Frontend (Mobile)
- **Flutter** - Framework para desenvolvimento mobile multiplataforma
- **Dart** - Linguagem de programação
- **Material Design** - Design system para interface do usuário

### Backend
- **Node.js** - Runtime JavaScript para servidor
- **Express.js** - Framework web para Node.js
- **MySQL** - Sistema de gerenciamento de banco de dados

### Principais Dependências
- `mysql_client: ^0.0.27` - Conexão com banco de dados MySQL
- `http: ^1.1.0` - Requisições HTTP
- `provider: ^6.1.1` - Gerenciamento de estado
- `flutter_dotenv: ^5.1.0` - Variáveis de ambiente

## 📁 Estrutura do Projeto

```
academia01/
├── lib/
│   ├── main.dart              # Ponto de entrada da aplicação
│   ├── commons/               # Utilitários e componentes comuns
│   │   ├── assets.dart
│   │   ├── colorScheme.dart
│   │   ├── cpfUtils.dart
│   │   └── caixaPergunta.dart
│   ├── models/                # Modelos de dados
│   │   ├── aluno.dart
│   │   ├── exercicio.dart
│   │   └── funcionario.dart
│   ├── services/              # Serviços de API
│   │   └── PadraoApiService.dart
│   ├── views/                 # Telas da aplicação
│   │   ├── splashPage.dart
│   │   └── login/
│   └── features/              # Funcionalidades específicas
│       └── pessoas/
├── assets/
│   └── imagens/
│       └── logo.png
├── backend_server.js          # Servidor Node.js
└── pubspec.yaml              # Dependências do Flutter
```

## ⚙️ Configuração e Instalação

### Pré-requisitos
- Flutter SDK (3.7.2 ou superior)
- Dart SDK
- Node.js
- MySQL
- Android Studio / VS Code

### Configuração do Backend
1. Configure as variáveis de ambiente no arquivo `.env`:

2. Instale as dependências do Node.js:
   ```bash
   npm install
   ```

3. Execute o servidor:
   ```bash
   node backend_server.js
   ```

### Configuração do Frontend
1. Instale as dependências do Flutter:
   ```bash
   flutter pub get
   ```

2. Execute a aplicação:
   ```bash
   flutter run
   ```

## 💾 Banco de Dados

O projeto utiliza MySQL para armazenar informações sobre:
- **Alunos** - Dados pessoais e informações de matrícula
- **Funcionários** - Dados dos colaboradores da academia
- **Exercícios** - Catálogo de exercícios disponíveis

## 🎯 Funcionalidades

- 📝 Cadastro e gerenciamento de alunos
- 👥 Gestão de funcionários
- 🏃‍♂️ Catálogo de exercícios
- 🔐 Sistema de autenticação
- 📱 Interface responsiva e intuitiva

## 🛠️ Desenvolvimento

Este projeto segue as melhores práticas de desenvolvimento Flutter:
- Arquitetura organizada em camadas
- Gerenciamento de estado com Provider
- Validação de dados (ex: CPF)
- Componentes reutilizáveis

## 📄 Licença

Este projeto é desenvolvido para fins acadêmicos por Samuel Spricigo.
