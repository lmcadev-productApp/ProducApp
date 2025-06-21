import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/utils/constants.dart';

class ProductionStageService {


  Future<List<ProductionStage>> getAllOrdersPerStages() async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/etapas-produccion/por-estado/PENDIENTE'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductionStage.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener etapas de producción');
    }
  }

  Future<ProductionStage> createProductionStage(ProductionStage stage) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/etapas-produccion'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(stage.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductionStage.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Error al crear etapa de producción');
    }
  }

  Future<void> deleteProductionStage(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/etapas-produccion/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar etapa de producción');
    }
  }

  Future<ProductionStage> getProductionStageById(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/etapas-produccion/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ProductionStage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Etapa de producción no encontrada');
    }
  }

  Future<void> updateProductionStage(ProductionStage stage) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/etapas-produccion/${stage.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(stage.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar etapa de producción');
    }
  }
}
