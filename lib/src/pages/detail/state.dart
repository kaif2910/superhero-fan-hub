part of marvel_cinema;

class TvShowState extends State<TvShow> {
  var currentSeason = 1;
  Set<int> _myListIds = {};
  @override
  void initState() {
    super.initState();
    _loadLocalState();
  }

  Future<void> _loadLocalState() async {
    final list = await LocalStore.getMyList();
    if (!mounted) return;
    setState(() => _myListIds = list);
  }

  Future<void> _toggleMyList(int id) async {
    final next = Set<int>.from(_myListIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    setState(() => _myListIds = next);
    await LocalStore.setMyList(next);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Episode> seasonEpisodes = widget.item.episodes
        .where((Episode e) => e.season == currentSeason)
        .toList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            primary: true,
            expandedHeight: 430.0,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: screenSize.width,
                      height: 220,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          mediaImage(
                            widget.item.image,
                            fit: BoxFit.fitWidth,
                          ),
                          Center(
                        child: Container(
                          height: 64.0,
                          width: 64.0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeRight,
                                DeviceOrientation.landscapeLeft,
                              ]).then((e) {
                                Application.router.navigateTo(
                                  context,
                                  Routes.video.replaceAll(':title', widget.item.name),
                                  routeSettings: RouteSettings(arguments: {
                                    'title': widget.item.name,
                                    'videoUrl': widget.item.videoUrl
                                  }),
                                  transition: TransitionType.inFromBottom,
                                );
                              });
                            },
                            child: Container(
                              height: 64.0,
                              width: 64.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 48.0,
                              ),
                            ),
                          ),
                        ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: 220,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [0.1, 0.4, 1.0],
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                              Colors.black
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.item.name,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220,
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 30.0),
                        width: screenSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${widget.match}% Match',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 255, 0, 0.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              widget.item.date.year.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              '16 +',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              '${widget.item.seasons.length} seasons',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: Text(
                                  widget.item.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.3),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Starring: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: widget.item.cast.join(', ')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.white70),
                                    onPressed: () => _toggleMyList(widget.item.id),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            _myListIds.contains(widget.item.id)
                                                ? Icons.check
                                                : Icons.add,
                                            size: 32.0,
                                          ),
                                          Text(
                                            _myListIds.contains(widget.item.id)
                                                ? 'Added'
                                                : 'My List',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.white70),
                                    onPressed: () => print('Rate'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.thumb_up,
                                            size: 24.0,
                                          ),
                                          Text(
                                            'Rate',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.white70),
                                    onPressed: () => print('Share'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.share,
                                            size: 20.0,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: Text(
                                  'EPISODES',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
                              onPressed: widget.item.seasons.length > 1
                                  ? () => print('cambiando Season')
                                  : null,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Season $currentSeason',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  (widget.item.seasons.length > 1
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.6),
                                          ),
                                        )
                                      : Container())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 8.0),
                              width: 150.0,
                              height: 90.0,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  mediaImage(
                                    seasonEpisodes[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                  Center(
                                child: Container(
                                  height: 32.0,
                                  width: 32.0,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.landscapeRight,
                                        DeviceOrientation.landscapeLeft,
                                      ]).then((e) {
                                        Application.router.navigateTo(
                                          context,
                                          Routes.video.replaceAll(':title', seasonEpisodes[index].name),
                                          routeSettings: RouteSettings(arguments: {
                                            'title': seasonEpisodes[index].name,
                                            'videoUrl': widget.item.videoUrl
                                          }),
                                          transition: TransitionType.inFromBottom,
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 32.0,
                                      width: 32.0,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.3),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${index + 1}. ${seasonEpisodes[index].name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                  ),
                                ),
                                Text(
                                  '${seasonEpisodes[index].duration}m',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Text(
                          seasonEpisodes[index].summary,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                          ),
                        )
                      ],
                    ),
                  ),
              childCount: seasonEpisodes.length,
            ),
          )
        ],
      ),
    );
  }
}

