import 'dart:convert';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/stages/stage.dart';

class StageService {
  final String baseUrl = 'http://localhost:8081/api/etapas';

  Future<List<Stage>> getAllStages() async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => Stage.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar etapas');
    }
  }

  Future<Stage> createStage(Stage stage) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(stage.toJson()),
    );

    if (response.statusCode == 200) {
      return Stage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear etapa');
    }
  }

  Future<Stage> updateStage(int id, Stage stage) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stage.toJson()),
    );

    if (response.statusCode == 200) {
      return Stage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar etapa');
    }
  }

  Future<void> deleteStage(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar etapa');
    }
  }
}
