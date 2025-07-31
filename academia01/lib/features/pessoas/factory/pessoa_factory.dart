import 'package:academia01/features/pessoas/model/pessoa.dart';
import 'package:academia01/features/pessoas/alunos/models/aluno.dart';
import 'package:academia01/features/pessoas/funcionarios/models/professor_model.dart';
import 'package:academia01/features/pessoas/funcionarios/models/funcionario_model.dart';
import 'package:academia01/features/pessoas/admin/model/admin_model.dart';


class PessoaFactory {

  static Pessoa createFromJson(Map<String, dynamic> json) {
    final nivel = json['nivel'] != null 
        ? NivelUsuario.fromString(json['nivel']) 
        : NivelUsuario.user;
    switch (nivel) {
      case NivelUsuario.user:
        return Aluno.fromJson(json);
      case NivelUsuario.professor:
        return Professor.fromJson(json);
      case NivelUsuario.funcionario:
        Funcionario aux = Funcionario.fromJson(json);
        return aux;
      case NivelUsuario.admin:
        return Admin.fromJson(json);
      case NivelUsuario.master:
        return Admin.fromJson(json);
    }
  }

  //verificacao se pode realizar uma ação (metodos de permicoes)
  static bool podeRealizarAcao(Pessoa pessoa, String acao) {
    switch (acao.toLowerCase()) {
      case 'gerenciar_alunos':
        return pessoa.podeGerenciarAlunos;
      case 'gerenciar_funcionarios':
        return pessoa.podeGerenciarFuncionarios;
      case 'acessar_academia':
        return pessoa.podeAcessarAcademia;
      default:
        return false;
    }
  }

  /// Filtra uma lista de pessoas por tipo
  static List<T> filtrarPorTipo<T extends Pessoa>(List<Pessoa> pessoas) {
    return pessoas.whereType<T>().toList();
  }
}
