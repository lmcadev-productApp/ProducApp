import 'dart:convert';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/stages/stage.dart';

class StageService {
  Future<List<Stage>> getAllStages() async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(Uri.parse('$baseUrl/etapas'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => Stage.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar etapas');
    }
  }

  Future<Stage> createStage(Stage stage) async {
    final token = await SharedPreferencesHelper.getToken();

    final bodyData = json.encode(stage.toJson());
    print('Enviando etapa: $bodyData');

    final response = await http.post(
      Uri.parse('$baseUrl/etapas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: bodyData,
    );

    print('Código de respuesta: ${response.statusCode}');
    print('Cuerpo de respuesta: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Stage.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Error al crear etapa: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Stage> updateStage(int id, Stage stage) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/etapas/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(stage.toJson()),
    );

    if (response.statusCode == 200) {
      return Stage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar etapa');
    }
  }

  Future<void> deleteStage(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.delete(Uri.parse('$baseUrl/etapas/$id'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar etapa');
    }
  }

  Future<void> assignStagesToOrder(int orderId, List<int> stageIds) async {
    final token = await SharedPreferencesHelper.getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/estapas-produccion/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(stageIds), // Enviamos lista de IDs como JSON
    );

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Error al asignar etapas a la orden');
    }
  }

}
