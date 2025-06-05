import 'package:frontend/models/users/user.dart';

class UserService {
  static List<Map<String, dynamic>> mockJsonData = [
    {
      "id": 1,
      "correo": "luis.castaneda@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Administrador",
      "nombre": "Luis Miguel Castañeda Arciniegas",
      "telefono": "3101234567",
      "direccion": "Calle 85 #15-20, Bogotá",
      "especialidad": {"id": null, "nombre": "", "descripcion": ""},
      "suguroSocial": "EPS Sanitas",
      "arl": "SURA ARL"
    },
    {
      "id": 2,
      "correo": "julian.cortes@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Supervisor",
      "nombre": "Julian David Cortes Cubides",
      "telefono": "3209876543",
      "direccion": "Carrera 7 #45-30, Bogotá",
      "especialidad": {"id": null, "nombre": "", "descripcion": ""},
      "suguroSocial": "EPS Compensar",
      "arl": "Positiva ARL"
    },
    {
      "id": 3,
      "correo": "william.cardenas@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Operador",
      "nombre": "William Felipe Cardenas Pelaez",
      "telefono": "32199847554",
      "direccion": "Calle 68 #10-15, Bogotá",
      "especialidad": {
        "id": "1",
        "nombre": "Pintura",
        "descripcion": "Aplicación de recubrimientos y acabados"
      },
      "suguroSocial": "EPS Nueva EPS",
      "arl": "Liberty ARL"
    },
    {
      "id": 4,
      "correo": "yuliana.cardenas@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Supervisor",
      "nombre": "Yuliana Aide Cardenas Jaramillo",
      "telefono": "3154567890",
      "direccion": "Carrera 15 #32-45, Bogotá",
      "especialidad": {"id": null, "nombre": "", "descripcion": ""},
      "suguroSocial": "EPS Famisanar",
      "arl": "SURA ARL"
    },
    {
      "id": 5,
      "correo": "juan.cortes@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Operador",
      "nombre": "Juan Felipe Cortes Guayara",
      "telefono": "32199847554",
      "direccion": "Calle 40 #25-10, Bogotá",
      "especialidad": {
        "id": 5,
        "nombre": "Ensamble",
        "descripcion": "Montaje y ensamblaje de componentes"
      },
      "suguroSocial": "EPS Cafam",
      "arl": "Positiva ARL"
    },
    {
      "id": 6,
      "correo": "maria.rodriguez@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Operador",
      "nombre": "Maria Fernanda Rodriguez Silva",
      "telefono": "3187654321",
      "direccion": "Carrera 30 #50-25, Bogotá",
      "especialidad": {
        "id": 6,
        "nombre": "Diseño",
        "descripcion": "Desarrollo de diseños y planos técnicos"
      },
      "suguroSocial": "EPS Sanitas",
      "arl": "Liberty ARL"
    },
    {
      "id": 7,
      "correo": "carlos.martinez@empresa.com",
      "contrasena": "pruebatest123",
      "rol": "Operador",
      "nombre": "Carlos Andres Martinez Lopez",
      "telefono": "3195432187",
      "direccion": "Calle 20 #18-35, Bogotá",
      "especialidad": {
        "id": 7,
        "nombre": "Procesamiento de Materia Prima",
        "descripcion": "Preparación y procesamiento de materiales"
      },
      "suguroSocial": "EPS Compensar",
      "arl": "SURA ARL"
    }
  ];

  // Getter para obtener la lista de usuarios
  static List<User> get users =>
      mockJsonData.map((json) => User.fromJson(json)).toList();

  // Método para obtener usuario por ID
  static User? getUserById(int id) {
    try {
      final userData = mockJsonData.firstWhere((user) => user['id'] == id);
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Método para obtener usuarios por rol
  static List<User> getUsersByRole(String role) {
    final filteredData =
        mockJsonData.where((user) => user['rol'] == role).toList();
    return filteredData.map((json) => User.fromJson(json)).toList();
  }

  // Método para obtener usuarios por especialidad
  static List<User> getUsersBySpecialty(String specialtyName) {
    final filteredData = mockJsonData
        .where((user) => user['especialidad']['nombre'] == specialtyName)
        .toList();
    return filteredData.map((json) => User.fromJson(json)).toList();
  }

  // Método para autenticar usuario
  static User? authenticateUser(String email, String password) {
    try {
      final userData = mockJsonData.firstWhere(
          (user) => user['correo'] == email && user['contrasena'] == password);
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Método para obtener operadores disponibles para asignación
  static List<User> getAvailableOperators() {
    return getUsersByRole('Operador');
  }

  // Método para obtener supervisores
  static List<User> getSupervisors() {
    return getUsersByRole('Supervisor');
  }

  // Método para obtener administradores
  static List<User> getAdministrators() {
    return getUsersByRole('Administrador');
  }
}
