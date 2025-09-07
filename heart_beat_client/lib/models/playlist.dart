class Playlist {
  final int id;
  final String name;

  Playlist({required this.id, required this.name});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(id: json['id'] as int, name: json['name'] as String);
  }
}
