part of netflix;

class VideoState extends State<Video> {
  late VideoPlayerController vcontroller;
  late bool controlVisible;
  Timer? timer;
  Timer? _introTimeout;
  bool _playingIntro = true;

  @override
  void initState() {
    controlVisible = false; // Hide controls during intro
    vcontroller = VideoPlayerController.asset('assets/video/promo.mp4')
      ..initialize().then((_) {
        if (!mounted) return;
        vcontroller.setVolume(0.0); // Mute for intro autoplay
        setState(() {});
        vcontroller.play();
      });

    vcontroller.addListener(_introListener);
    
    // Safety timeout for intro: 5 seconds max
    _introTimeout = Timer(Duration(seconds: 5), () {
      if (_playingIntro) _startMainVideo();
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  void _introListener() {
    if (_playingIntro && vcontroller.value.position >= vcontroller.value.duration && vcontroller.value.duration != Duration.zero) {
      _startMainVideo();
    }
  }

  void _startMainVideo() {
    if (!mounted) return;
    _introTimeout?.cancel();
    vcontroller.removeListener(_introListener);
    vcontroller.dispose();
    
    setState(() {
      _playingIntro = false;
      controlVisible = true;
    });

    if (widget.videoUrl.startsWith('http')) {
      vcontroller = VideoPlayerController.network(widget.videoUrl);
    } else {
      vcontroller = VideoPlayerController.asset(
          widget.videoUrl.isNotEmpty ? widget.videoUrl : 'assets/video/promo.mp4');
    }

    vcontroller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      vcontroller.play();
      autoHide();
    });
  }

  @override
  void dispose() {
    _introTimeout?.cancel();
    vcontroller.dispose();
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 0.75;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PlayerLifeCycle(
            vcontroller,
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(vcontroller),
                ),
          ),
          GestureDetector(
            child: PlayerControl(
              vcontroller,
              visible: controlVisible,
              title: widget.title,
            ),
            onTap: handlerGesture,
          ),
        ],
      ),
    );
  }
}
