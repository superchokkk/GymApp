import 'package:academia01/features/pessoas/model/pessoa.dart';

class Professor extends Pessoa{

  Professor({
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

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'] ?? '',
      nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.professor,
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

  //modificações dos metodos do pai
  @override
  bool get podeGerenciarAlunos => true;
  @override
  bool get podeGerenciarFuncionarios => false;
  @override
  String get tipoUsuario => 'Professor';

  //metodos especificos do Professor
  bool get podeCriarTreinos => true;
  bool get podeAvaliarAlunos => true;
  bool get podeMinistrarAulas => true;
  String get statusFuncional => idFuncao > 0 ? 'Ativo' : 'Inativo';

  // Método para verificar se pode supervisionar um aluno
  bool podeSupervisionar(int idAlunoAcademia) {
    return podeGerenciarAlunos && podeAcessarAcademia;
  }
}