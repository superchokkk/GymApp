import 'package:academia01/features/pessoas/model/pessoa.dart';

class Funcionario extends Pessoa{

  Funcionario({
    required super.id,
    required super.nome,
    required super.idade,
    required super.email,
    required super.cpf,
    required super.senha,
    required super.nivel,
    super.idAcademia = 0,
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
        senha: json['senha'] ?? '',
        nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.funcionario,
        idFuncao: json['idfuncao'] ?? json['idFuncao'] ?? 0,
        salario: _parseDouble(json['salario']),
      );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
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
      'idfuncao': idFuncao,
      'salario': salario,
    };
  }

  //metodos modificados do pai
  @override
  bool get podeGerenciarAlunos => false;
  
  @override
  bool get podeGerenciarFuncionarios => false;

  @override
  String get tipoUsuario => 'Funcionário';

  //metodos expecificos
  String get statusFuncional => idFuncao > 0 ? 'Ativo' : 'Inativo';
}