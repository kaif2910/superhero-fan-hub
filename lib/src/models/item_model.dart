part of marvel_cinema;

class ItemModel {
  late String _title;
  List<Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _title = parsedJson['title'] ?? '';
    _results = parsedJson['items'] != null
        ? List.from(parsedJson['items'])
            .map(
              (r) => Result.fromJson(r),
            )
            .toList()
        : [];
  }

  List<Result> get results => _results;
  String get title => _title;
}
