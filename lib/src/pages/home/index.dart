part of netflix;

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  HomeState createState() => HomeState();
}
