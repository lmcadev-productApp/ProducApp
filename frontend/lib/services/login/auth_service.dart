import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart'; // Asegúrate que baseUrl esté bien definido
import 'package:frontend/models/login/login_request.dart';
import 'package:frontend/models/login/login_response.dart';

class AuthService {
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginResponse.fromJson(data);
      } else {
        print('Error al iniciar sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Excepción durante login: $e');
      res
      return null;
    }
  }
}
