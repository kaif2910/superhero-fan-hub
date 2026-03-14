part of netflix;

class LocalStore {
  static const String _myListKey = 'my_list_ids';
  static const String _progressKey = 'continue_progress';

  static Future<Set<int>> getMyList() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_myListKey) ?? <String>[];
    return raw.map((e) => int.tryParse(e) ?? 0).where((e) => e > 0).toSet();
  }

  static Future<void> setMyList(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = ids.map((e) => e.toString()).toList();
    await prefs.setStringList(_myListKey, raw);
  }

  static Future<Map<int, double>> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = json.decode(raw) as Map<String, dynamic>;
      final Map<int, double> out = {};
      decoded.forEach((key, value) {
        final id = int.tryParse(key);
        final v = (value is num) ? value.toDouble() : 0.0;
        if (id != null && id > 0) out[id] = v.clamp(0.0, 1.0);
      });
      return out;
    } catch (_) {
      return {};
    }
  }

  static Future<void> setProgress(Map<int, double> progress) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, double> enc = {};
    progress.forEach((key, value) {
      enc[key.toString()] = value.clamp(0.0, 1.0);
    });
    await prefs.setString(_progressKey, json.encode(enc));
  }
}
