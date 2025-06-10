import 'dart:convert';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/constants.dart';

class OrderService {
  /// GET Obtener toda las ordenes de trabajo
  Future<List<Order>> getOrders() async {
    final token = await SharedPreferencesHelper.getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/ordenes/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final token = await SharedPreferencesHelper.getToken();
    print('Token usado: $token');

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener ordenes de trabajo');
    }
  }


  /// POST Crear una nueva orden de trabajo
  Future<String> createOrder(Order order) async {
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
  Future<String> updateOrden(int id, Order order) async {
    final jsonBody = json.encode(order.toJson());
    final token = await SharedPreferencesHelper.getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/ordenes/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al actualizar la orden de trabajo');
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
