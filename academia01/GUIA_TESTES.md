# 🧪 Guia de Testes - Academia App

Este guia explica como testar a conexão e funcionalidades do banco de dados do seu projeto Academia.

## 📋 Resumo da Arquitetura

```
UI/Views → Controllers → Repositories → Services → MySQL
```

### 🔧 **Services** (`mysql_service.dart`)
- **Função**: Comunicação direta com MySQL
- **Faz**: Conexão, queries SQL, transações
- **Métodos**: `query()`, `execute()`, `testConnection()`

### 🗂️ **Repositories** (`academia_repository.dart`)
- **Função**: Acesso a dados por entidade
- **Faz**: Mapear SQL para objetos Dart
- **Métodos**: `buscarPorNome()`, `inserir()`, `deletar()`

### 🎮 **Controllers** (`academia_controller.dart`)
- **Função**: **Ponte entre UI e dados** + regras de negócio
- **Faz**: Validações, lógica de negócio, coordenação
- **Métodos**: `cadastrarAcademia()`, `listarTodasAcademias()`

## 🚀 Como Testar

### 1. Teste Rápido de Conexão

```bash
cd academia01
dart lib/teste_conexao_simples.dart
```

**O que testa:**
- ✅ Conexão com MySQL
- ✅ Versão do banco
- ✅ Existência da tabela
- ✅ Contagem de registros

### 2. Teste Completo do Sistema

```bash
cd academia01
dart lib/test_database.dart
```

**O que testa:**
- ✅ Conexão
- ✅ Queries básicas (Service)
- ✅ Operações CRUD (Repository)
- ✅ Validações e regras (Controller)
- ✅ Transações

### 3. Exemplo de Uso Completo

```bash
cd academia01
dart lib/exemplo_completo.dart
```

**Demonstra:**
- 📋 Listagem de academias
- ➕ Cadastro com validação
- 🔍 Busca por nome
- ❌ Tratamento de erros
- 🔄 Prevenção de duplicatas

## 🛠️ Configuração Necessária

### 1. Verificar MySQL

Certifique-se que o MySQL está rodando:

**Windows + XAMPP:**
```bash
# Abrir XAMPP Control Panel
# Start → MySQL
```

**Windows + MySQL Standalone:**
```bash
# Services.msc → MySQL80 → Start
net start mysql80
```

### 2. Criar Banco de Dados

```sql
CREATE DATABASE academia;
USE academia;
```

### 3. Executar Script SQL

Execute o arquivo `backend/arquivosql.sql` no seu MySQL:

```bash
# Via linha de comando:
mysql -u root -p academia < backend/arquivosql.sql

# Ou via phpMyAdmin/MySQL Workbench
```

### 4. Verificar Credenciais

No arquivo `lib/services/mysql_service.dart`:

```dart
static final ConnectionSettings _settings = ConnectionSettings(
  host: 'localhost',        // ✅ Correto
  port: 3306,              // ✅ Padrão MySQL
  user: 'root',            // ✅ Verificar
  password: '',            // ⚠️ Verificar sua senha
  db: 'academia',          // ✅ Nome do banco
);
```

## 🐛 Solução de Problemas

### ❌ "Connection refused"
```
Soluções:
1. MySQL não está rodando
2. Porta 3306 bloqueada
3. Host/porta incorretos
```

### ❌ "Access denied"
```
Soluções:
1. Usuário/senha incorretos
2. Usuário sem permissões
3. Banco não existe
```

### ❌ "Table doesn't exist"
```
Soluções:
1. Executar arquivosql.sql
2. Verificar nome do banco
3. Verificar nome das tabelas
```

### ❌ "Unknown database"
```
Soluções:
1. CREATE DATABASE academia;
2. Verificar nome no mysql_service.dart
```

## 📊 Exemplo de Saída dos Testes

### ✅ Teste de Conexão (Sucesso)
```
🔌 Testando conexão com MySQL...

✅ SUCESSO: Conectado ao MySQL!
📊 Versão do MySQL: 8.0.33
🗃️ Banco atual: academia
✅ Tabela "academias" encontrada
📈 Total de academias: 3

🔌 Conexão fechada.
```

### ✅ Teste Completo (Sucesso)
```
🧪 ===== INICIANDO TESTES DO BANCO DE DADOS =====

🔌 Testando conexão com o banco de dados...
✅ Conexão com MySQL estabelecida com sucesso!

📝 Testando queries básicas...
✅ Versão do MySQL: 8.0.33
✅ Tabela "academias" encontrada
✅ Total de registros na tabela: 3

🗂️ Testando Repository...
✅ Buscar todas: 3 academias encontradas
✅ Inserção: Academia criada com ID 4
✅ Buscar por nome: Academia encontrada
✅ Deleção: Academia removida com sucesso

🎮 Testando Controller...
✅ Listar todas: 3 academias via controller
✅ Validação funcionando: Nome da academia não pode estar vazio
✅ Cadastro via controller: Academia criada com ID 5
✅ Limpeza: Academia de teste removida

🔄 Testando transações...
✅ Academia inserida na transação com ID 6
✅ Transação concluída com sucesso, ID: 6
✅ Limpeza da transação concluída

✅ ===== TODOS OS TESTES CONCLUÍDOS COM SUCESSO =====
```

## 🎯 Dicas de Desenvolvimento

### 1. Para debugar queries
```dart
// Ativar logs detalhados
Logger.root.level = Level.ALL;
```

### 2. Para testar validações
```dart
// Sempre teste dados inválidos
final invalidData = Academia(nome: '', ...);
```

### 3. Para testar transações
```dart
// Simule erros para verificar rollback
throw Exception('Teste rollback');
```

### 4. Para monitorar performance
```dart
final stopwatch = Stopwatch()..start();
await _repository.buscarTodas();
print('Tempo: ${stopwatch.elapsedMilliseconds}ms');
```

---

## 📝 Próximos Passos

1. ✅ Testar conexão básica
2. ✅ Executar testes completos
3. ✅ Verificar todas as validações
4. 🔨 Implementar testes unitários
5. 🔨 Adicionar mais entidades (Aluno, Funcionario)
6. 🔨 Criar interface gráfica (Flutter)

---

**💡 Lembre-se**: Sempre teste a conexão antes de implementar novas funcionalidades!
