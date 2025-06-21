import 'dart:convert';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart';

class OrderService {
  /// GET Obtener toda las ordenes de trabajo
  Future<List<WorkOrders>> getOrders() async {
    final token = await SharedPreferencesHelper.getToken();
    print("Entron a la consulta GET");
    final response = await http.get(
      Uri.parse('$baseUrl/ordenes'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Token usado: $token');

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => WorkOrders.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener ordenes de trabajo');
    }
  }

  /// POST Crear una nueva orden de trabajo
  Future<String> createOrder(WorkOrders order) async {
    final token = await SharedPreferencesHelper.getToken();

    final jsonBody = json.encode(order.toJson());
    print('JSON a enviar: $jsonBody');

    final response = await http.post(
      Uri.parse('$baseUrl/ordenes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonBody,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al crear una orden de trabajo');
    }
  }

  /// PUT Actualizar una orden de trabajo
  Future<String> updateOrden(int id, WorkOrders order) async {
    final token = await SharedPreferencesHelper.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token no encontrado. Por favor, inicia sesión.');
    }

    final jsonBody = json.encode(order.toJson());

    print('Actualizando orden con ID $id');
    print('Token usado: $token');
    print('JSON enviado: $jsonBody');

    final response = await http.put(
      Uri.parse('$baseUrl/ordenes/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    print('STATUS: ${response.statusCode}');
    print('RESPONSE: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      return response.body.isNotEmpty
          ? response.body
          : 'Orden actualizada exitosamente';
    } else {
      final errorMessage = 'Error ${response.statusCode}: ${response.body}';
      throw Exception('Error al actualizar la orden de trabajo. $errorMessage');
    }
  }

  /// Obtener todas las ordenes de trabajo por estado
  Future<List<WorkOrders>> getOrdersByEstado(String estado) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/ordenes/estado?estado=$estado'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => WorkOrders.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener órdenes por estado');
    }
  }


  /// DELETE Eliminar un usuario
  Future<String> deleteOrder(int id) async {
    final token = await SharedPreferencesHelper.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/ordenes/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al eliminar la orden de trabajo');
    }
  }
}




