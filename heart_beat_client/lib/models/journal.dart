class Journal {
  final int id;
  final String title;
  final String content;
  final String moods;
  final DateTime createdAt;

  Journal({
    required this.id,
    required this.title,
    required this.content,
    required this.moods,
    required this.createdAt,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      moods: json['moods_assigned'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
