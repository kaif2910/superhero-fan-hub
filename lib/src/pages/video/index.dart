part of marvel_cinema;

class Video extends StatefulWidget {
  final String title;
  final String videoUrl;
  Video({Key? key, required this.title, required this.videoUrl}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}
