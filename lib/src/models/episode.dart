part of marvel_cinema;

class Episode {
  late int _number;
  late int _season;
  late String _image;
  late String _summary;
  late String _name;
  late int _duration;

  Episode.fromJson(Map<String, dynamic> parsedJson) {
    RegExp exp = new RegExp(r"<[^>]*>");
    _number = parsedJson['number'] ?? 0;
    _season = parsedJson['season'] ?? 0;
    
    if (parsedJson['image'] is String) {
      _image = parsedJson['image'];
    } else {
      _image = (parsedJson['image'] ?? {})['medium'] ?? '';
    }
    
    _summary = parsedJson['summary'] != null
        ? parsedJson['summary'].replaceAll(exp, '')
        : '';
    _name = parsedJson['name'] ?? '';
    
    if (parsedJson['runtime'] != null) {
      _duration = int.parse(parsedJson['runtime'].toString());
    } else if (parsedJson['airtime'] != null &&
            parsedJson['airtime'].toString().isNotEmpty) {
      _duration = int.parse(parsedJson['airtime'].split(':')[0]);
    } else {
      _duration = 0;
    }
  }

  int get number => _number;
  int get season => _season;
  String get image => _image;
  String get summary => _summary;
  String get name => _name;
  int get duration => _duration;
}
