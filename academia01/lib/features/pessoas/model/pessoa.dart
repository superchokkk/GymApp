enum NivelUsuario {
  admin('ADMIN'),
  user('USER'),
  professor('PROFESSOR');

  const NivelUsuario(this.value);
  final String value;

  static NivelUsuario fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ADMIN':
        return NivelUsuario.admin;
      case 'USER':
        return NivelUsuario.user;
      case 'PROFESSOR':
        return NivelUsuario.professor;
      default:
        return NivelUsuario.user; // valor padrão
    }
  }
}

class Pessoa {
  final int id;
  final String nome;
  final int idade;
  final String email;
  final String cpf;
  final String senha;
  final NivelUsuario nivel;

  Pessoa({
    required this.id, 
    required this.nome, 
    required this.idade, 
    required this.email, 
    required this.cpf, 
    required this.senha,
    this.nivel = NivelUsuario.user
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'],
      nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'email': email,
      'cpf': cpf,
      'senha': senha,
      'nivel': nivel.value,
    };
  }
}