class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,

    required this.token,
  });

  // Convert JSON response to UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
    final token = json['token'] as String? ?? "";
    return UserModel(
      id: userJson?['id'] as int? ?? 0, // Use null-aware operators and type casting
      name: userJson?['name'] as String? ?? "",
      email: userJson?['email'] as String? ?? "",
      token: token,
    );
  }

  // Convert UserModel object to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "token": token,
    };
  }
}