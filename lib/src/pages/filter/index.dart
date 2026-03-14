part of netflix;

class Filter extends StatefulWidget {
  final String title;
  final String type;
  Filter({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  FilterState createState() => FilterState();
}
