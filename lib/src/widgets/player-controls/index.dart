part of marvel_cinema;

class PlayerControl extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;
  final bool visible;

  PlayerControl(this.controller, {required this.visible, required this.title, Key? key}) : super(key: key);

  @override
  PlayerControlState createState() => PlayerControlState();
}
