class LoginResponse {
  final String token;
  final String rol;
  final String id;

  LoginResponse({required this.token, required this.rol, required this.id});

  /// Crea una instancia de `LoginResponse` a partir de un mapa JSON.
  ///
  /// Este constructor de fábrica toma un mapa JSON y extrae los valores
  /// de las claves `token` y `rol` para inicializar una instancia de `LoginResponse`.
  ///
  /// Parámetros:
  /// - `json`: Un mapa de tipo `Map<String, dynamic>` que contiene los datos JSON.
  ///
  /// Retorna:
  /// - Una nueva instancia de `LoginResponse` con los valores extraídos del JSON.
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      rol: json['rol'],
      id: json['id'],
    );
  }
}
