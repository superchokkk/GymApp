import 'package:academia01/features/pessoas/model/pessoa.dart';

class Funcionario extends Pessoa {

  Funcionario({
    required super.id,
    required super.nome,
    required super.idade,
    required super.email,
    required super.cpf,
    required super.senha,
    required super.nivel,
    required super.idFuncao,
    required super.salario,
  });
  
  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'],
      nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.user,
      idFuncao: json['idFuncao'],
      salario: json['salario'].toDouble(),
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
      'nivel': nivel.value,
      'idFuncao': idFuncao,
      'salario': salario,
    };
  }
}