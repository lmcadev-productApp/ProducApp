import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _tokenKey = 'token';
  static const String _rolKey = 'rol';
  static const String _userIdKey =
      'userId'; // Se guarda el ID del usuario actual

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

  /// Obtener el ID del usuario
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  /// Eliminar ID de usuario
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  /// Guarda el ID del usuario actual
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }
}
