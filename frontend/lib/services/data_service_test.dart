import 'package:frontend/models/admin/user_test.dart';

class DataService {
  static List<Map<String, dynamic>> mockJsonData = [
    {
      "name": "Luis Miguel Castañeda Arciniegas",
      "email": "luis.castaneda@empresa.com",
      "role": "Administrador",
      "password": "pruebatest123",
    },
    {
      "name": "Julian David Cortes Cubides",
      "email": "julian.cortes@empresa.com",
      "role": "Supervisor",
      "password": "pruebatest123",
    },
    {
      "name": "William Felipe Cardenas Pelaez",
      "email": "william.cardenas@empresa.com",
      "role": "Operador",
      "password": "pruebatest123",
      "celular": "32199847554",
      "especialidad": "Pintura",
    },
    {
      "name": "Yuliana Aide Cardenas Jaramillo",
      "email": "yuliana.cardenas@empresa.com",
      "role": "Supervisor",
      "password": "pruebatest123",
    },
    {
      "name": "Juan Felipe Cortes Guayara",
      "email": "juan.cortes@empresa.com",
      "role": "Operador",
      "password": "pruebatest123",
      "celular": "32199847554",
      "especialidad": "Pintura",
    },
  ];

  static List<User> get users =>
      mockJsonData.map((json) => User.fromJson(json)).toList();
}
