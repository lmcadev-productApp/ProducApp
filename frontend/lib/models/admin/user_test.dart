class User {
  final String name;
  final String email;
  final String role;
  final String? password; // Opcional
  final String? celular; // Opcional
  final String? especialidad; // Opcional

  User({
    required this.name,
    required this.email,
    required this.role,
    this.password,
    this.celular,
    this.especialidad,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      password: json['password'],
      celular: json['celular'],
      especialidad: json['especialidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'password': password,
      'celular': celular,
      'especialidad': especialidad,
    };
  }
}
