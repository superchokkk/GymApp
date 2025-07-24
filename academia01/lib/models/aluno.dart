import 'package:academia01/features/pessoas/model/pessoa.dart';

class Aluno extends Pessoa{
  final int idAcademia;

  Aluno({
    required int id,
    required String nome,
    required int idade,
    required String email,
    required String cpf,
    required String senha,
    required NivelUsuario? nivel,
    required this.idAcademia,
  }) : super(id: id, nome: nome, idade: idade, email: email, cpf: cpf, senha: senha, nivel: nivel ?? NivelUsuario.user);

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'] ?? '',
      idAcademia: json['idAcademia'],
      nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.user
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
      'idAcademia': idAcademia,
    };
  }
}