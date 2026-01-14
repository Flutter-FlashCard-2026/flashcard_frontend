class Voca {
  final int id;
  final int userId;
  final String title;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Voca({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    this.updatedAt,
  });

  // JSON(Map) -> User 객체로 변환하는 생성자: factory
  factory Voca.fromJson(Map<String, dynamic> json) {
    return Voca(
      id: json['id'], 
      userId: json['user_id'], 
      title: json['title'], 
      createdAt: DateTime.parse(json['created_at']),
      // 수정일이 있으면 변환하고, null이면 null로 둠
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  // copyWith: 일부 값만 바꾼 새 객체 생성
  Voca copyWith({String? title, DateTime? updatedAt}) {
    return Voca(id: id, userId: userId, title: title ?? this.title, 
      createdAt: createdAt, updatedAt: updatedAt ?? this.updatedAt);
  }
}