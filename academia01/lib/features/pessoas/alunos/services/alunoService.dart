import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aluno.dart';
import '../../model/pessoa.dart';

class AlunoService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Buscar aluno por CPF via API
  static Future<Pessoa?> buscarAlunoPorCpf(String cpf) async {
    try {
      
      final response = await http.get(
        Uri.parse('$baseUrl/aluno/cpf/$cpf'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final aluno = Aluno.fromJson(data);
        return aluno;
      } else if (response.statusCode == 404) {
        print('Aluno não encontrado para o CPF: $cpf');
        return null;
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar aluno por CPF: $e');
      return null;
    }
  }
}
