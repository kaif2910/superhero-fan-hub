part of marvel_cinema;

class ShowsList extends StatelessWidget {
  final ScrollController controller = ScrollController();
  final String title;
  final List<Result> items;
  final Function onTap;

  ShowsList({
    required this.title,
    required this.items,
    required this.onTap,
  });

  List<Widget> renderItems() {
    return items.map((item) {
      return InkWell(
        onTap: () => onTap(item, 99),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          width: 120.0,
          height: 140.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: mediaImage(item.image, fit: BoxFit.cover),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: renderItems(),
            ),
          )
        ],
      ),
    );
  }
}
