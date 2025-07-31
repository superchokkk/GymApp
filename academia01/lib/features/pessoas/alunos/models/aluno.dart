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
      'nivel': nivel.value,
      'idAcademia': idAcademia,
    };
  }

  //metodos modificados do pai
  @override
  bool get podeGerenciarAlunos => false;
  @override
  bool get podeGerenciarFuncionarios => false;
  @override
  String get tipoUsuario => 'Aluno';

  //metodos especificos do Aluno
  bool get podeAcessarTreinos => true;
  bool get podeFazerMatricula => true;
  String get statusMatricula => idAcademia > 0 ? 'Matriculado' : 'Sem matrícula';

  // Método para verificar se pode acessar uma academia específica
  bool podeAcessarAcademiaEspecifica(int idAcademiaVerificar) {
    return idAcademia == idAcademiaVerificar;
  }
}