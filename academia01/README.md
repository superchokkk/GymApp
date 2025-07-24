# 🏋️‍♂️ Academia01 - Sistema de Gestão de Academia

<div align="center">
  <img src="assets/imagens/logo.png" alt="Academia01 Logo" width="200"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.7.2-blue.svg)](https://flutter.dev/)
  [![Node.js](https://img.shields.io/badge/Node.js-Backend-green.svg)](https://nodejs.org/)
  [![MySQL](https://img.shields.io/badge/MySQL-Database-orange.svg)](https://www.mysql.com/)
  [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
</div>

## 📋 Sobre o Projeto

**Academia01** é um sistema completo de gestão para academias, desenvolvido com Flutter para o frontend mobile e Node.js para o backend. O sistema permite o gerenciamento de alunos, funcionários e academias, oferecendo uma experiência moderna e intuitiva.

### ✨ Principais Funcionalidades

- 👥 **Gestão de Alunos**: Cadastro, consulta e gerenciamento de dados dos alunos
- 🏢 **Gestão de Academias**: Controle de múltiplas unidades
- 👨‍💼 **Gestão de Funcionários**: Sistema de controle de acesso por níveis
- 🔐 **Sistema de Login**: Autenticação segura com validação de CPF
- 📱 **Interface Responsiva**: Design moderno e adaptável
- 🎯 **API RESTful**: Backend robusto e escalável

## 🛠️ Tecnologias Utilizadas

### Frontend (Mobile)
- **Flutter 3.7.2** - Framework principal
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **HTTP** - Requisições para API
- **MySQL Client** - Conexão com banco de dados

### Backend
- **Node.js** - Runtime JavaScript
- **Express.js** - Framework web
- **MySQL2** - Driver para MySQL
- **CORS** - Controle de acesso
- **dotenv** - Variáveis de ambiente

### Banco de Dados
- **MySQL** - Sistema de gerenciamento de banco de dados

## 🚀 Como Executar o Projeto

### Pré-requisitos

- Flutter SDK 3.7.2 ou superior
- Node.js 16.0 ou superior
- MySQL 8.0 ou superior
- Git

### 📱 Configuração do Frontend (Flutter)

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/academia01.git
cd academia01
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Configure as variáveis de ambiente**
```bash
# Crie um arquivo .env na raiz do projeto
cp .env.example .env
```

4. **Execute o aplicativo**
```bash
flutter run
```

### 🖥️ Configuração do Backend (Node.js)

1. **Navegue até o diretório do projeto**
```bash
cd academia01
```

2. **Instale as dependências do Node.js**
```bash
npm init -y
npm install express mysql2 cors dotenv
```

3. **Configure as variáveis de ambiente**
```bash
# Crie um arquivo .env com as seguintes variáveis:
DB_HOST=localhost
DB_PORT=3306
DB_USER=seu_usuario
DB_PASSWORD=sua_senha
DB_DATABASE=academia_db
SERVER_PORT=8080
```

4. **Execute o servidor**
```bash
node backend_server.js
```

### 🗄️ Configuração do Banco de Dados

1. **Crie o banco de dados MySQL**
```sql
CREATE DATABASE academia_db;
USE academia_db;

-- Tabela de pessoas (base para alunos e funcionários)
CREATE TABLE pessoas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    idade INT,
    email VARCHAR(255) UNIQUE,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel ENUM('aluno', 'funcionario', 'admin') DEFAULT 'aluno'
);

-- Tabela de academias
CREATE TABLE academias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(20)
);

-- Tabela de alunos
CREATE TABLE alunos (
    id INT PRIMARY KEY,
    idAcademia INT,
    FOREIGN KEY (id) REFERENCES pessoas(id),
    FOREIGN KEY (idAcademia) REFERENCES academias(id)
);

-- Tabela de funcionários
CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    idAcademia INT,
    cargo VARCHAR(100),
    FOREIGN KEY (id) REFERENCES pessoas(id),
    FOREIGN KEY (idAcademia) REFERENCES academias(id)
);
```

## 📁 Estrutura do Projeto

```
academia01/
├── 📱 lib/                     # Código fonte Flutter
│   ├── 🏠 main.dart           # Arquivo principal
│   ├── 🎨 commons/            # Utilitários comuns
│   │   ├── assets.dart
│   │   ├── colorScheme.dart
│   │   └── cpfUtils.dart
│   ├── 🔧 features/           # Funcionalidades por módulo
│   ├── 📊 models/             # Modelos de dados
│   │   ├── aluno.dart
│   │   ├── exercicio.dart
│   │   └── funcionario.dart
│   ├── 🌐 services/           # Serviços de API
│   └── 📺 views/              # Telas da aplicação
├── 🖼️ assets/                  # Recursos estáticos
│   └── imagens/
├── 🔙 backend_server.js       # Servidor Node.js
├── 📋 pubspec.yaml           # Dependências Flutter
└── 📖 README.md              # Este arquivo
```

## 🔗 Endpoints da API

### Alunos
- `GET /api/aluno/cpf/:cpf` - Buscar aluno por CPF
- `GET /api/academias` - Listar todas as academias

### Exemplo de Uso
```bash
# Buscar aluno por CPF
curl http://localhost:8080/api/aluno/cpf/12345678901

# Listar academias
curl http://localhost:8080/api/academias
```

## 🎯 Funcionalidades Implementadas

- ✅ Sistema de login com validação de CPF
- ✅ Busca de alunos por CPF
- ✅ Listagem de academias
- ✅ Conexão com banco MySQL
- ✅ API RESTful
- ✅ Interface de usuário responsiva
- ✅ Splash screen
- ✅ Validação de dados

## 🔮 Próximas Funcionalidades

- [ ] Cadastro de novos alunos
- [ ] Sistema de treinos e exercícios
- [ ] Relatórios e dashboards
- [ ] Notificações push
- [ ] Sistema de pagamentos
- [ ] Chat interno
- [ ] Agendamento de aulas

## 🤝 Como Contribuir

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Desenvolvedor

Desenvolvido com ❤️ por [Seu Nome]

---

<div align="center">
  <p>⭐ Se este projeto te ajudou, considere dar uma estrela!</p>
  
  [![GitHub stars](https://img.shields.io/github/stars/seu-usuario/academia01.svg?style=social&label=Star)](https://github.com/seu-usuario/academia01)
  [![GitHub forks](https://img.shields.io/github/forks/seu-usuario/academia01.svg?style=social&label=Fork)](https://github.com/seu-usuario/academia01/fork)
</div>
