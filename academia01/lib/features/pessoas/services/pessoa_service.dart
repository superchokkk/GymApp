import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/pessoa.dart';
import '../factory/pessoa_factory.dart';
import '../alunos/models/aluno.dart';

class PessoaService {
  static const String baseUrl = 'http://localhost:8080/api';

  static List<Pessoa> _pessoasCache = [];

  static Future<Pessoa?> buscarPessoaPorCpf(String cpf) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cliente/cpf/$cpf'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final pessoa = PessoaFactory.createFromJson(data);
        _adicionarAoCache(pessoa);
        return pessoa;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }

  // Buscar aluno específico por CPF
  static Future<Aluno?> buscarAlunoPorCpf(String cpf) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/aluno/cpf/$cpf'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final aluno = Aluno.fromJson(data);
        _adicionarAoCache(aluno);
        return aluno;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //envia email
  static Future<bool> sendEmail(String email, String codigo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send_email/$email/$codigo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static void _adicionarAoCache(Pessoa pessoa) {
    _pessoasCache.removeWhere((p) => p.cpf == pessoa.cpf);
    _pessoasCache.add(pessoa);
  }

  // Limpar cache
  static void limparCache() {
    _pessoasCache.clear();
  }

  // Obter cache completo
  static List<Pessoa> obterCacheCompleto() {
    return List.unmodifiable(_pessoasCache);
  }

  // Buscar no cache por CPF
  static Pessoa? buscarNoCachePorCpf(String cpf) {
    try {
      return _pessoasCache.firstWhere((pessoa) => pessoa.cpf == cpf);
    } catch (e) {
      return null;
    }
  }
}
