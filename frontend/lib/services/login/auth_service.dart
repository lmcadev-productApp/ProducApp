import 'dart:convert';
import 'dart:io';
import 'dart:async'; // Para TimeoutException
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart';
import 'package:frontend/models/login/login_request.dart';
import 'package:frontend/models/login/login_response.dart';
import 'package:frontend/services/users/user_service.dart';


class AuthService {
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(Duration(seconds: 10)); // opcional

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Obtener ID del usuario buscando por su correo
        final userService = UserService();
        final userId = await userService.buscarUserIdPorCorreo(request.correo);
        if (userId != null) {
          await SharedPreferencesHelper.saveUserId(userId);
        }

        return LoginResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        // Credenciales inválidas: devolver null
        return null;
      } else {
        // Otro error del servidor: lanzar excepción
        throw HttpException(
            'Error inesperado del servidor: ${response.statusCode}');
      }
    } on SocketException {
      throw SocketException('No se pudo conectar al servidor');
    } on TimeoutException {
      throw TimeoutException('Tiempo de espera agotado');
    } catch (e) {
      // Otro error inesperado
      throw Exception('Error desconocido: $e');
    }
  }
}
