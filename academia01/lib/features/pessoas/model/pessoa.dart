//import 'package:flutter/widgets.dart';

enum NivelUsuario {
  admin('ADMIN'),
  user('USER'),
  professor('PROFESSOR'),
  funcionario('FUNCIONARIO'),
  master('MASTER');

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
      case 'FUNCIONARIO':
        return NivelUsuario.funcionario;
      case 'MASTER':
        return NivelUsuario.master;
      default:
        return NivelUsuario.user;
    }
  }
}

abstract class Pessoa {
  final int id;
  final String nome;
  final int idade;
  final String email;
  final String cpf;
  final String senha;
  final NivelUsuario nivel;
  final int idAcademia;
  final int idFuncao;
  final double salario;

  Pessoa({
    required this.id, 
    required this.nome, 
    required this.idade, 
    required this.email, 
    required this.cpf, 
    required this.senha,
    required this.nivel,
    this.idAcademia = 0,
    this.idFuncao = 0,
    this.salario = 0,
  });

  //metodos que devem ser implementados pelas filhas
  Map<String, dynamic> toJson();
  
  //metodos que podem ser sobrescritos
  String get tipoUsuario => nivel.value;

  bool get podeAcessarAcademia => true;

  bool get podeGerenciarAlunos {
    return nivel == NivelUsuario.admin || 
           nivel == NivelUsuario.master || 
           nivel == NivelUsuario.professor;
  }
  
  bool get podeGerenciarFuncionarios {
    return nivel == NivelUsuario.admin || nivel == NivelUsuario.master;
  }
}