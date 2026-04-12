import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:audio_service/audio_service.dart';
import '../models/track_model.dart';
import 'stats_service.dart';

class AudioPlayerService {
  AudioPlayerService._();
  static final AudioPlayerService instance = AudioPlayerService._();

  final AudioPlayer _player = AudioPlayer();

  Track? _currentTrack;
  DateTime? _playStartedAt;
  bool _isRepeat = false;

  // ─────────────────────────────────────────────────────
  // Getters
  // ─────────────────────────────────────────────────────

  Track? get currentTrack => _currentTrack;
  bool get isRepeat => _isRepeat;
  bool get isPlaying => _player.playing;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  // ─────────────────────────────────────────────────────
  // Initialise (call once in main.dart)
  // ─────────────────────────────────────────────────────

  Future<void> init() async {
    // When a track finishes naturally, handle repeat or stop
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (_isRepeat) {
          _player.seek(Duration.zero);
          _player.play();
        } else {
          _recordListeningTime();
        }
      }
    });
  }

  // ─────────────────────────────────────────────────────
  // Playback control
  // ─────────────────────────────────────────────────────

  Future<void> playTrack(Track track) async {
    // Record time for previous track before switching
    _recordListeningTime();

    _currentTrack = track;
    _playStartedAt = DateTime.now();

    final audioSource = AudioSource.uri(
      Uri.parse(track.audioUrl),
      tag: MediaItem(
        id: track.id,
        album: track.genre,
        title: track.title,
        artist: track.artist,
        artUri: track.coverUrl.isNotEmpty ? Uri.parse(track.coverUrl) : null,
      ),
    );

    await _player.setAudioSource(audioSource);
    await _player.play();
  }

  Future<void> pause() async {
    _recordListeningTime();
    await _player.pause();
  }

  Future<void> resume() async {
    _playStartedAt = DateTime.now();
    await _player.play();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    _player.setLoopMode(_isRepeat ? LoopMode.one : LoopMode.off);
  }

  Future<void> dispose() async {
    _recordListeningTime();
    await _player.dispose();
  }

  // ─────────────────────────────────────────────────────
  // Stats recording
  // ─────────────────────────────────────────────────────

  void _recordListeningTime() {
    if (_playStartedAt == null || _currentTrack == null) return;
    final seconds = DateTime.now().difference(_playStartedAt!).inSeconds;
    if (seconds > 0) {
      StatsService.instance.recordPlay(_currentTrack!.id, seconds);
    }
    _playStartedAt = null;
  }
}
