import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // GET - Buscar dados
  Future<List<Map<String, dynamic>>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // POST - Inserir dados
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }
      throw Exception('Erro ao inserir dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT - Atualizar dados
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Erro ao atualizar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // DELETE - Deletar dados
  Future<bool> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
