class NivelUsuario {
	static ADMIN = 'ADMIN';
	static USER = 'USER';
	static PROFESSOR = 'PROFESSOR';
	static FUNCIONARIO = 'FUNCIONARIO';
	static MASTER = 'MASTER';

	static fromString(value) {
		switch (value.toUpperCase()) {
			case 'ADMIN': return NivelUsuario.ADMIN;
			case 'USER': return NivelUsuario.USER;
			case 'PROFESSOR': return NivelUsuario.PROFESSOR;
			case 'FUNCIONARIO': return NivelUsuario.FUNCIONARIO;
			case 'MASTER': return NivelUsuario.MASTER;
			default: return NivelUsuario.USER;
		}
	}
}

class Pessoa {
	constructor({
		id,
		nome,
		idade,
		email,
		cpf,
		senha,
		nivel,
		idAcademia = 0,
		idFuncao = 0,
		salario = 0,
	}) {
		this.id = id;
		this.nome = nome;
		this.idade = idade;
		this.email = email;
		this.cpf = cpf;
		this.senha = senha;
		this.nivel = nivel;
		this.idAcademia = idAcademia;
		this.idFuncao = idFuncao;
		this.salario = salario;
	}

	toJson() {
		return {
			id: this.id,
			nome: this.nome,
			idade: this.idade,
			email: this.email,
			cpf: this.cpf,
			senha: this.senha,
			nivel: this.nivel,
			idAcademia: this.idAcademia,
			idFuncao: this.idFuncao,
			salario: this.salario,
		};
	}

	get tipoUsuario() {
		return this.nivel;
	}

	get podeAcessarAcademia() {
		return true;
	}

	get podeGerenciarAlunos() {
		return [NivelUsuario.ADMIN, NivelUsuario.MASTER, NivelUsuario.PROFESSOR].includes(this.nivel);
	}

	get podeGerenciarFuncionarios() {
		return [NivelUsuario.ADMIN, NivelUsuario.MASTER].includes(this.nivel);
	}
}

module.exports = { Pessoa, NivelUsuario };
