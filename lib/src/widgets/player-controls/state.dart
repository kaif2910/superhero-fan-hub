part of marvel_cinema;

class PlayerControlState extends State<PlayerControl> {
  VideoPlayerController get controller => widget.controller;
  String get title => widget.title;
  bool get visible => widget.visible;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), init);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() {
    if (mounted)
      controller.addListener(() {
        if (mounted) setState(() {});
      });
  }

  void replay(double min, double current) {
    double anchor = current - 10000;
    controller
        .seekTo(Duration(milliseconds: (anchor < min ? min : anchor).round()));
  }

  void forward(double max, double current) {
    double anchor = current + 10000;
    controller
        .seekTo(Duration(milliseconds: (anchor > max ? max : anchor).round()));
  }

  void playcontinue() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = controller.value.duration;
    Duration position = controller.value.position;
    
    int timeDuration = duration.inMilliseconds - position.inMilliseconds;
    Duration timeline = Duration(milliseconds: (timeDuration < 0 ? 0 : timeDuration));
    String durationText = timeline.toString().split('.').first;
    
    final Size screenSize = MediaQuery.of(context).size;
    double currentValue = position.inMilliseconds.toDouble();
    final double minValue = 0.0;
    double maxValue = duration.inMilliseconds.toDouble();
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: screenSize.height,
      width: screenSize.width,
      color: Color.fromRGBO(0, 0, 0, 0.3),
      padding:
          EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
      child: Opacity(
        opacity: visible ? 1 : 0,
        child: visible
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenSize.width,
                    height: 30.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Container(
                          width: screenSize.width - 100.0,
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: 268.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          color: Colors.white,
                          iconSize: 40.0,
                          icon: Icon(Icons.replay_10),
                          onPressed: () => replay(minValue, currentValue),
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 80.0,
                          icon: Icon(controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: playcontinue,
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 40.0,
                          icon: Icon(Icons.forward_10),
                          onPressed: () => forward(maxValue, currentValue),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: screenSize.width - 90.0,
                        child: Slider(
                          activeColor: Color.fromRGBO(219, 0, 0, 1.0),
                          inactiveColor: Color.fromRGBO(86, 77, 77, 1.0),
                          value:
                              currentValue > maxValue ? maxValue : currentValue,
                          onChanged: (double value) => controller
                              .seekTo(Duration(milliseconds: value.round())),
                          min: minValue,
                          max: maxValue,
                        ),
                      ),
                      Text(
                        durationText,
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      )
                    ],
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
