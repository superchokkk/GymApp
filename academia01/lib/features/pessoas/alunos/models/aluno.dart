import 'package:academia01/features/pessoas/model/pessoa.dart';

class Aluno extends Pessoa{

  Aluno({
    required super.id,
    required super.nome,
    required super.idade,
    required super.email,
    required super.cpf,
    required super.senha,
    super.nivel = NivelUsuario.user,
    required super.idAcademia,
  });

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

  @override
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