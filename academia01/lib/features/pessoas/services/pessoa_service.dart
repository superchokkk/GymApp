import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/pessoa.dart';

class PessoaService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Buscar cliente por CPF via API
  static Future<Pessoa?> buscarPessoaPorCpf(String cpf) async {
    try {
      
      final response = await http.get(
        Uri.parse('$baseUrl/cliente/cpf/$cpf'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final cliente = Pessoa.fromJson(data);
        return cliente;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }
}
