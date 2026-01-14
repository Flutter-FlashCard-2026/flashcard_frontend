class User {
  final int id;
  final String email;
  final String name;
  final DateTime createdAt;
  
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  // JSON(Map) → User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
  