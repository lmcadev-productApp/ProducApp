import 'dart:convert';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/specialty/specialty.dart';

class SpecialtyService {
  Future<List<Specialty>> getAllSpecialties() async {
    final token = await SharedPreferencesHelper.getToken();
    final response =
        await http.get(Uri.parse('$baseUrl/especialidades'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => Specialty.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar especialidades');
    }
  }

  Future<Specialty> createSpecialty(Specialty specialty) async {
    final token = await SharedPreferencesHelper.getToken();

    final bodyData = json.encode(specialty.toJson());
    print('Enviando especialidad: $bodyData');
    print(token);
    final response = await http.post(
      Uri.parse('$baseUrl/especialidades'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: bodyData,
    );

    print('Código de respuesta: ${response.statusCode}');
    print('Cuerpo de respuesta: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Specialty.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Error al crear especialidad: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Specialty> updateSpecialty(int id, Specialty specialty) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/especialidades/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(specialty.toJson()),
    );

    if (response.statusCode == 200) {
      return Specialty.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar especialidad');
    }
  }

  Future<void> deleteSpecialty(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.delete(Uri.parse('$baseUrl/especialidades/$id'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar especialidad');
    }
  }
}
