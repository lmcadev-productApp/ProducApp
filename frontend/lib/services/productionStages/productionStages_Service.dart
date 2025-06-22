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

  Future<void> asignarOperario(int etapaId, int usuarioId, String estado, String fechaInicio) async {
    final token = await SharedPreferencesHelper.getToken();

 // Asegúrate de que el estado sea correcto
    final response = await http.put(
      Uri.parse('$baseUrl/etapas-produccion/asignar-operario/$etapaId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'usuarioId': usuarioId,
        'estado': estado,
        'fechaInicio': fechaInicio
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al asignar operario');
    }
  }

  //adquirir etapa de produccion por id de usuario actual y estado
  Future<List<ProductionStage>> getStagesByUserAndStatus() async {


    final token = await SharedPreferencesHelper.getToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final response = await http.get(
      Uri.parse('$baseUrl/etapas-produccion/usuario/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductionStage.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener etapas de producción por usuario y estado');
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
