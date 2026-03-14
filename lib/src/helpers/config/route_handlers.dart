part of netflix;

var rootHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return Home(title: 'Home');
  },
);
var summaryRouteHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return Summary(title: 'Summary');
  },
);
var detailRouteHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final args = context!.settings!.arguments as Map<String, dynamic>;
    return TvShow(match: args['match'], item: args['show']);
  },
);
var trailerRouteHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final args = context!.settings!.arguments as Map<String, dynamic>;
    return Video(
      title: args['title'] ?? 'Trailer',
      videoUrl: args['videoUrl'] ?? '',
    );
  },
);
var filterRouteHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final args = context!.settings!.arguments as Map<String, dynamic>;
    return Filter(
      type: args['type'],
      title: args['title'] ?? 'Filter',
    );
  },
);
