class Song {
  final int id;
  final String title;
  final String artist;
  final int duration;
  final String songUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.songUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as int,
      title: json['title'] as String,
      artist: json['artist'] as String,
      duration: json['duration'] as int,
      songUrl: json['song_url'] as String,
    );
  }
}
