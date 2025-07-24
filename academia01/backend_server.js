// backend_server.js (Node.js)
require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

// Verificar se todas as variáveis de ambiente necessárias estão definidas
const requiredEnvVars = ['DB_HOST', 'DB_PORT', 'DB_USER', 'DB_DATABASE', 'SERVER_PORT'];
const missingEnvVars = requiredEnvVars.filter(envVar => !process.env[envVar]);

if (missingEnvVars.length > 0) {
  console.error('Variáveis de ambiente obrigatórias não definidas:', missingEnvVars);
  console.error('Por favor, configure o arquivo .env com as variáveis necessárias.');
  process.exit(1);
}

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE
});

// Testar conexão
db.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao MySQL:', err);
    return;
  }
  console.log('Conectado ao MySQL!');
});

// GET /api/aluno/cpf/:cpf - Buscar aluno por CPF
app.get('/api/aluno/cpf/:cpf', (req, res) => {
  const cpf = req.params.cpf;
  // Query para buscar aluno pelo CPF
  const query = `
    SELECT a.id, a.nome, a.idade, a.email, a.cpf, a.senha, a.nivel, b.idAcademia
    FROM pessoas as a
    INNER JOIN alunos as b ON a.id = b.id
    WHERE a.cpf = ?
  `;
  
  db.query(query, [cpf], (err, results) => {
    if (err) {
      console.error('Erro na query:', err);
      return res.status(500).json({error: err.message});
    }
    
    if (results.length === 0) {
      return res.status(404).json({message: 'Aluno não encontrado'});
    }

    const aluno = results[0];
    res.json({
      id: aluno.id,
      nome: aluno.nome,
      idade: aluno.idade,
      email: aluno.email,
      cpf: aluno.cpf,
      senha: aluno.senha,
      nivel: aluno.nivel,
      idAcademia: aluno.idAcademia
    });
  });
});

// GET /api/academias
app.get('/api/academias', (req, res) => {
  db.query('SELECT * FROM academias', (err, results) => {
    if (err) return res.status(500).json({error: err.message});
    res.json(results);
  });
});

const PORT = process.env.SERVER_PORT || 8080;

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
  console.log(`Endpoint: http://localhost:${PORT}/api/aluno/cpf/SEU_CPF`);
});

// Para instalar: npm init -y && npm install express mysql2 cors dotenv
// Para rodar: node backend_server.js
