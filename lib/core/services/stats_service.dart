import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  StatsService._();
  static final StatsService instance = StatsService._();

  static const _prefixDaily = 'daily_seconds_';
  static const _prefixPlayCount = 'play_count_';
  static const _keyGoalHours = 'monthly_goal_hours';
  static const _defaultGoalHours = 20;

  // ─────────────────────────────────────────────────────
  // Recording
  // ─────────────────────────────────────────────────────

  /// Record [seconds] of listening for [trackId] on today's date.
  Future<void> recordPlay(String trackId, int seconds) async {
    if (seconds <= 0) return;
    final prefs = await SharedPreferences.getInstance();

    // Daily listening
    final dayKey = _dailyKey(DateTime.now());
    final currentDaily = prefs.getInt(dayKey) ?? 0;
    await prefs.setInt(dayKey, currentDaily + seconds);

    // Per-track play count
    final countKey = '$_prefixPlayCount$trackId';
    final currentCount = prefs.getInt(countKey) ?? 0;
    await prefs.setInt(countKey, currentCount + 1);
  }

  // ─────────────────────────────────────────────────────
  // Queries
  // ─────────────────────────────────────────────────────

  /// Total listening seconds across all tracked days.
  Future<int> getTotalListeningSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    int total = 0;
    for (final key in prefs.getKeys()) {
      if (key.startsWith(_prefixDaily)) {
        total += prefs.getInt(key) ?? 0;
      }
    }
    return total;
  }

  /// Minutes listened per day for the current month.
  /// Returns a map where the key is the day-of-month (1–31).
  Future<Map<int, double>> getDailyMinutesThisMonth() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final Map<int, double> result = {};

    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(now.year, now.month, day);
      final key = _dailyKey(date);
      final seconds = prefs.getInt(key) ?? 0;
      result[day] = seconds / 60.0;
    }
    return result;
  }

  /// Play counts for all tracked tracks, sorted descending.
  /// Returns list of [trackId, playCount] pairs.
  Future<List<MapEntry<String, int>>> getMostPlayedTracks() async {
    final prefs = await SharedPreferences.getInstance();
    final entries = <MapEntry<String, int>>[];

    for (final key in prefs.getKeys()) {
      if (key.startsWith(_prefixPlayCount)) {
        final trackId = key.replaceFirst(_prefixPlayCount, '');
        final count = prefs.getInt(key) ?? 0;
        entries.add(MapEntry(trackId, count));
      }
    }

    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  // ─────────────────────────────────────────────────────
  // Monthly goal
  // ─────────────────────────────────────────────────────

  Future<int> getMonthlyGoalHours() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGoalHours) ?? _defaultGoalHours;
  }

  Future<void> setMonthlyGoalHours(int hours) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGoalHours, hours);
  }

  // ─────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────

  String _dailyKey(DateTime date) {
    return '$_prefixDaily${date.year}_${date.month}_${date.day}';
  }

  /// Returns total listening hours for the current month.
  Future<double> getThisMonthListeningHours() async {
    final dailyMinutes = await getDailyMinutesThisMonth();
    final totalMinutes =
        dailyMinutes.values.fold<double>(0.0, (a, b) => a + b);
    return totalMinutes / 60.0;
  }

  /// Formatted string like "4h 23m"
  static String formatSeconds(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}
