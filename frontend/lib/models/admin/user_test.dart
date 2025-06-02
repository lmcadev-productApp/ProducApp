class User {
  final String name;
  final String email;
  final String role;

  User({required this.name, required this.email, required this.role});

  //Recibir los datos del backend
  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email'], role: json['role']);
  }

  //Enviar los datos al backend
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'role': role};
  }
}
