import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _tokenKey = 'token';
  static const String _rolKey = 'rol';

  /// Guarda el token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Obtener el token guardado
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Eliminar el token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// Guarda el rol
  static Future<void> saveRol(String rol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_rolKey, rol);
  }

  /// Obtener el rol guardado
  static Future<String?> getRol() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rolKey);
  }

  /// Eliminar el rol
  static Future<void> clearRol() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rolKey);
  }
}
