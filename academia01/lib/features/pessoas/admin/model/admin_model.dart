import 'package:academia01/features/pessoas/model/pessoa.dart';

class Admin extends Pessoa{

  Admin({
    required super.id,
    required super.nome,
    required super.idade,
    required super.email,
    required super.cpf,
    required super.senha,
    super.nivel = NivelUsuario.admin,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'] ?? '',
      nivel: json['nivel'] != null ? NivelUsuario.fromString(json['nivel']) : NivelUsuario.admin
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
    };
  }

  // Implementações polimórficas específicas do Admin
  @override
  bool get podeGerenciarAlunos => true;
  
  @override
  bool get podeGerenciarFuncionarios => true;

  @override
  String get tipoUsuario => nivel == NivelUsuario.master ? 'Master Admin' : 'Administrador';

  // Métodos específicos do Admin
  bool get podeGerenciarSistema => true;
  
  bool get podeConfigurarAcademias => true;
  
  bool get podeVisualizarRelatorios => true;
  
  bool get podeGerenciarPermissoes => nivel == NivelUsuario.master;

  // Método para verificar se é super admin
  bool get isMaster => nivel == NivelUsuario.master;

  // Método para realizar operações administrativas
  bool podeRealizarOperacao(String operacao) {
    switch (operacao.toLowerCase()) {
      case 'criar_usuario':
      case 'editar_usuario':
      case 'deletar_usuario':
        return podeGerenciarAlunos || podeGerenciarFuncionarios;
      case 'configurar_sistema':
        return podeGerenciarSistema;
      case 'gerenciar_academias':
        return podeConfigurarAcademias;
      case 'alterar_permissoes':
        return podeGerenciarPermissoes;
      default:
        return false;
    }
  }

  // Método para obter todas as permissões
  List<String> get permissoes {
    List<String> perms = ['acessar_sistema', 'visualizar_relatorios'];
    
    if (podeGerenciarAlunos) perms.add('gerenciar_alunos');
    if (podeGerenciarFuncionarios) perms.add('gerenciar_funcionarios');
    if (podeGerenciarSistema) perms.add('gerenciar_sistema');
    if (podeConfigurarAcademias) perms.add('configurar_academias');
    if (podeGerenciarPermissoes) perms.add('gerenciar_permissoes');
    
    return perms;
  }
}