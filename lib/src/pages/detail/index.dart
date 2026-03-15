part of marvel_cinema;

class TvShow extends StatefulWidget {
  final int match;
  final Result item;

  TvShow({
    Key? key,
    required this.match,
    required this.item,
  }) : super(key: key);

  @override
  TvShowState createState() => TvShowState();
}
