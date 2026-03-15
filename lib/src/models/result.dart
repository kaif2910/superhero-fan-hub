part of marvel_cinema;

class Result {
  late int id;
  late String _name;
  late String _image;
  late String _backdrop;
  late String _videoUrl;
  late List<String> _genres;
  late List<String> _cast;
  late List<Episode> _episodes;
  List<int> _seasons = [];
  late DateTime _date;
  late String _description;

  Result.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'] ?? 0;
    _name = parsedJson['name'] ?? '';
    _image = parsedJson['image'] ?? '';
    _backdrop = parsedJson['backdrop'] ?? _image;
    _videoUrl = parsedJson['videoUrl'] ?? '';
    _genres = parsedJson['details'] != null && parsedJson['details']['genres'] != null
        ? List.from(parsedJson['details']['genres'])
            .map((genre) => genre.toString())
            .toList()
        : [];
    _cast = parsedJson['details'] != null && parsedJson['details']['cast'] != null
        ? List.from(parsedJson['details']['cast'])
            .map((cast) => cast['person'] != null ? cast['person']['name'].toString() : '')
            .toList()
        : [];
    _date = parsedJson['year'] != null
        ? DateTime.parse(parsedJson['year'].toString())
        : DateTime.now();
    RegExp exp = new RegExp(r"<[^>]*>");
    _description = parsedJson['details'] != null && parsedJson['details']['description'] != null
        ? parsedJson['details']['description'].replaceAll(exp, '')
        : '';
    _episodes = parsedJson['details'] != null && parsedJson['details']['episodes'] != null
        ? List.from(parsedJson['details']['episodes'])
            .map((e) => Episode.fromJson(e))
            .toList()
        : [];
    if (parsedJson['details'] != null && parsedJson['details']['episodes'] != null) {
      List.from(parsedJson['details']['episodes']).forEach((s) {
        int seasonNumber = int.parse(s['season'].toString());
        if (!_seasons.contains(seasonNumber)) _seasons.add(seasonNumber);
      });
    }
  }

  String get name => _name;
  String get image => _image;
  String get backdrop => _backdrop;
  String get videoUrl => _videoUrl;
  List<String> get genres => _genres;
  List<String> get cast => _cast;
  DateTime get date => _date;
  String get description => _description;
  List<Episode> get episodes => _episodes;
  List<int> get seasons => _seasons;
}
