class Word {
  final int id;
  final int vocaId;
  final String term;
  final String meaning;
  final bool memorized;
  final DateTime createdAt;

  Word({
    required this.id,
    required this.vocaId,
    required this.term,
    required this.meaning,
    this.memorized = false,
    required this.createdAt,
  });

  // JSON(Map) -> User 객체로 변환하는 생성자: factory
  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'], 
      vocaId: json['voca_id'], 
      term: json['term'], 
      meaning: json['meaning'], 
      memorized: json['memorized'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  // copyWith: 일부 값만 바꾼 새 객체 생성
  Word copyWith({String? term, String? meaning, bool? memorized}) {
    return Word(id: id, vocaId: vocaId,  term: term ?? this.term, meaning: meaning ?? this.meaning,
      memorized: memorized ?? this.memorized, createdAt: createdAt);
  }
}