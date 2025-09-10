class Playlist {
  final int id;
  final String name;
  final String color;

  Playlist({required this.id, required this.name, required this.color});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
    );
  }
}
