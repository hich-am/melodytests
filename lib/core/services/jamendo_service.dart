import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/track_model.dart';

class JamendoService {
  JamendoService._();
  static final JamendoService instance = JamendoService._();

  // ─────────────────────────────────────────────────────
  // 🔑 Replace with your Jamendo Client ID from:
  //    https://developer.jamendo.com/
  // ─────────────────────────────────────────────────────
  static const String _clientId = 'YOUR_CLIENT_ID';

  static const String _baseUrl = 'https://api.jamendo.com/v3.0';

  /// Fetch tracks from Jamendo, grouped by genre.
  Future<List<Track>> fetchTracks({int limit = 30}) async {
    final uri = Uri.parse(
      '$_baseUrl/tracks/'
      '?client_id=$_clientId'
      '&format=json'
      '&limit=$limit'
      '&include=musicinfo'
      '&imagesize=200',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Jamendo API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>? ?? [];

    return results
        .map((json) => Track.fromJamendoJson(json as Map<String, dynamic>))
        .where((t) => t.audioUrl.isNotEmpty)
        .toList();
  }

  /// Returns tracks grouped by genre.
  Future<Map<String, List<Track>>> fetchTracksByGenre({int limit = 30}) async {
    final tracks = await fetchTracks(limit: limit);
    final Map<String, List<Track>> grouped = {};
    for (final track in tracks) {
      grouped.putIfAbsent(track.genre, () => []).add(track);
    }
    return grouped;
  }

  /// Fetch tracks for a specific genre tag.
  Future<List<Track>> fetchTracksByTag(String tag, {int limit = 20}) async {
    final uri = Uri.parse(
      '$_baseUrl/tracks/'
      '?client_id=$_clientId'
      '&format=json'
      '&limit=$limit'
      '&tags=$tag'
      '&include=musicinfo'
      '&imagesize=200',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Jamendo API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>? ?? [];

    return results
        .map((json) => Track.fromJamendoJson(json as Map<String, dynamic>))
        .where((t) => t.audioUrl.isNotEmpty)
        .toList();
  }
}
