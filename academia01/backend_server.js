// backend_server.js (Node.js)
import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import mysql from 'mysql2';
import cors from 'cors';
import { sendCodigoEmail } from './lib/services/email.js';

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

//Obtem usuario e identifica nivel
app.get('/api/cliente/cpf/:cpf', (req, res) => {
  const cpf = req.params.cpf;

  // Querys
  const query = `
    SELECT id, nome, idade, email, cpf, senha, nivel
    FROM pessoas
    WHERE cpf = ?
  `;
  
  const queryAluno = `
    SELECT a.idAcademia
    FROM pessoas as b 
    INNER JOIN alunos as a ON b.id = a.id
    WHERE b.cpf = ?
  `;
  
  const queryProfessor = `
    SELECT a.idfuncao, a.salario
    FROM pessoas as b 
    INNER JOIN funcionarios as a ON b.id = a.id
    WHERE b.cpf = ?
  `;

  db.query(query, [cpf], (err, results) => {
    if (err) {
      console.error('Erro na query:', err);
      return res.status(500).json({ error: err.message });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'Cliente não encontrado' });
    }

    const cliente = results[0];
    
    //verificacao dos niveis
    if (cliente.nivel === 'USER') {
      db.query(queryAluno, [cpf], (err, alunoResults) => {
        if (err) {
          console.error('Erro na query do aluno:', err);
          return res.status(500).json({ error: err.message });
        }
        
        const aluno = alunoResults.length > 0 ? alunoResults[0] : {};
        
        res.json({
          id: cliente.id,
          nome: cliente.nome,
          idade: cliente.idade,
          email: cliente.email,
          cpf: cliente.cpf,
          senha: cliente.senha,
          nivel: cliente.nivel,
          idAcademia: aluno.idAcademia,
          idfuncao: null,
          salario: null
        });
      });
      
    } else if (cliente.nivel === 'PROFESSOR' || cliente.nivel === 'FUNCIONARIO') {
      db.query(queryProfessor, [cpf], (err, professorResults) => {
        if (err) {
          console.error('Erro na query do funcionário:', err);
          return res.status(500).json({ error: err.message });
        }
        
        const professor = professorResults.length > 0 ? professorResults[0] : {};
        
        res.json({
          id: cliente.id,
          nome: cliente.nome,
          idade: cliente.idade,
          email: cliente.email,
          cpf: cliente.cpf,
          senha: cliente.senha,
          nivel: cliente.nivel,
          idAcademia: null,
          idfuncao: professor.idfuncao,
          salario: professor.salario
        });
      });
      
    } else {
      res.json({
        id: cliente.id,
        nome: cliente.nome,
        idade: cliente.idade,
        email: cliente.email,
        cpf: cliente.cpf,
        senha: cliente.senha,
        nivel: cliente.nivel,
        idAcademia: null,
        idfuncao: null,
        salario: null
      });
    }
  });
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
      return res.status(500).json({ error: err.message });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'Aluno não encontrado' });
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
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

//POST /api/send_email (emailDestinatario, codigo)
app.post('/api/send_email', async (req, res) => {
  const { email, codigo } = req.body;

  const sendEmailSuccess = await sendCodigoEmail(email, codigo);
  if (sendEmailSuccess) {
    res.json({ success: true });
  } else {
    res.status(500).json({ success: false });
  }
});

//PATCH /api/redefine_password (novaSenha, id)
app.patch('/api/redefine_password', (req, res) => {
  const { novaSenha, id } = req.body;

  const query = 'UPDATE pessoas SET senha = ? WHERE id = ?';
  db.query(query, [novaSenha, id], (err, results) => {
    if (err) {
      console.error('Erro na query:', err);
      return res.status(500).json({ error: err.message });
    }
    res.json({ success: true });
  });
});

const PORT = process.env.SERVER_PORT || 8080;

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
  console.log(`Endpoint: http://localhost:${PORT}/api/aluno/cpf/SEU_CPF`);
});

// Para instalar: npm init -y && npm install express mysql2 cors dotenv
// Para rodar: node backend_server.js