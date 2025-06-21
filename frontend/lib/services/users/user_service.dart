import 'dart:convert';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart';
import 'package:frontend/models/users/user.dart';

class UserService {
  /// GET Obtener todos los usuarios
  Future<List<User>> getUsers() async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  /// GET Obtener un usuario por ID
  Future<User> getUserById(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }

  ///Obtener el usuario actual autenticado desde SharedPreferences
  Future<User?> getUsuarioActual() async {
    final userIdString = await SharedPreferencesHelper.getUserId();
    if (userIdString == null) return null;

    final userId = int.tryParse(userIdString);
    if (userId == null) return null;

    try {
      return await getUserById(userId);
    } catch (e) {
      print('Error al obtener el usuario actual: $e');
      return null;
    }
  }

  /// POST Crear un nuevo usuario
  Future<String> createUser(User user) async {
    final token = await SharedPreferencesHelper.getToken();

    final jsonBody = json.encode(user.toJson());
    print('JSON a enviar: $jsonBody');

    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonBody,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al crear el usuario');
    }
  }

  /// PUT Actualizar un usuario existente
  Future<String> updateUser(int id, User user) async {
    final jsonBody = json.encode(user.toJson());
    final token = await SharedPreferencesHelper.getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al actualizar el usuario');
    }
  }

  /// DELETE Eliminar un usuario
  Future<String> deleteUser(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al eliminar el usuario');
    }
  }

  /// Buscar usuario por correo
  Future<String?> buscarUserIdPorCorreo(String correo) async {
    final url = Uri.parse('$baseUrl/usuarios');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${await SharedPreferencesHelper.getToken()}',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> usuarios = jsonDecode(response.body);
        final usuario = usuarios.firstWhere(
          (u) => u['correo'].toString().toLowerCase() == correo.toLowerCase(),
          orElse: () => null,
        );
        return usuario?['id']?.toString();
      } else {
        print('Error al obtener usuarios: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error buscando usuario por correo: $e');
      return null;
    }
  }
}
