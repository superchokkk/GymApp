import 'package:academia01/features/pessoas/model/pessoa.dart';

class Funcionario extends Pessoa {
  final String cargo;
  final double salario;

  Funcionario({
    required int id,
    required String nome,
    required int idade,
    required String email,
    required String cpf,
    required String senha,
    required this.cargo,
    required this.salario,
  }) : super(id: id, nome: nome, idade: idade, email: email, cpf: cpf, senha: senha);

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'],
      cargo: json['cargo'],
      salario: json['salario'].toDouble(),
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
      'cargo': cargo,
      'salario': salario,
    };
  }
}