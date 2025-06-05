import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart';
import 'package:frontend/models/login/login_request.dart';
import 'package:frontend/models/login/login_response.dart';

class AuthService {
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

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
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Excepción capturada durante el login: $e');
      return null;
    }
  }
}
