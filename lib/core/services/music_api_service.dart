import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/track_model.dart';

class MusicApiService {
  MusicApiService._();
  static final MusicApiService instance = MusicApiService._();

  static const String _baseUrl = 'https://freemusicarchive.org/api/get/tracks.json';

  /// Fetch tracks from FMA.
  Future<List<Track>> fetchTracks({int limit = 30}) async {
    final uri = Uri.parse('$_baseUrl?limit=$limit');

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('FMA API error: ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      
      // Assume 'dataset' holds the list of tracks as per common FMA API structure
      final results = data['dataset'] as List<dynamic>? ?? [];

      return results
          .map((json) => Track.fromFmaJson(json as Map<String, dynamic>))
          .where((t) => t.audioUrl.isNotEmpty) // Ensure playable audio
          .toList();
    } catch (e) {
      // Return an empty list or mock list on failure to ensure UI doesn't crash completely
      print('FMA API failure: $e');
      return [];
    }
  }

  /// Groups tracks by a default genre key or "Various" for UI categorisation.
  Future<Map<String, List<Track>>> fetchTracksByGenre({int limit = 30}) async {
    final tracks = await fetchTracks(limit: limit);
    final Map<String, List<Track>> grouped = {};
    for (final track in tracks) {
      grouped.putIfAbsent(track.genre, () => []).add(track);
    }
    return grouped;
  }
}
