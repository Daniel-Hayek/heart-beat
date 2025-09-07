class MoodTracking {
  final int id;
  final String source;
  final String mood;
  final int score;
  final DateTime timestamp;

  MoodTracking({
    required this.id,
    required this.source,
    required this.mood,
    required this.score,
    required this.timestamp,
  });

  factory MoodTracking.fromJson(Map<String, dynamic> json) {
    return MoodTracking(
      id: json['id'] as int,
      source: json['source'] as String,
      mood: json['mood'] as String,
      score: json['score'] as int,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
