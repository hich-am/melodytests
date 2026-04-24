class Track {
  final String id;
  final String title;
  final String artist;
  final String audioUrl;
  final String coverUrl;
  final String genre;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.audioUrl,
    required this.coverUrl,
    required this.genre,
  });

  factory Track.fromFmaJson(Map<String, dynamic> json) {
    return Track(
      id: json['track_id']?.toString() ?? '',
      title: json['track_title']?.toString() ?? 'Unknown Title',
      artist: json['artist_name']?.toString() ?? 'Unknown Artist',
      audioUrl: json['track_file']?.toString() ?? '',
      coverUrl: json['album_image']?.toString() ?? '',
      genre: 'Various',
    );
  }

  factory Track.fromFirestoreMap(String id, Map<String, dynamic> data) {
    return Track(
      id: id,
      title: data['title'] ?? 'Unknown Title',
      artist: data['artist'] ?? 'Unknown Artist',
      audioUrl: data['audioUrl'] ?? '',
      coverUrl: data['coverUrl'] ?? '',
      genre: data['genre'] ?? 'Various',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'audioUrl': audioUrl,
      'coverUrl': coverUrl,
      'genre': genre,
    };
  }

  @override
  bool operator ==(Object other) => other is Track && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
