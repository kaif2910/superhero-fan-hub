part of marvel_cinema;

class SplashState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Simply wait for 2 seconds and go to home
    Timer(Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainHome(title: widget.title)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png', width: 200),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeState extends State<MainHome> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    controller = TabController(length: 5, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: TabBar(
        labelStyle: TextStyle(fontSize: 10.0),
        indicatorWeight: 0.1,
        controller: controller,
        tabs: <Widget>[
          Tab(text: 'Home', icon: Icon(Icons.home)),
          Tab(text: 'Search', icon: Icon(Icons.search)),
          Tab(text: 'Coming Soon', icon: Icon(Icons.ondemand_video)),
          Tab(text: 'Downloads', icon: Icon(Icons.file_download)),
          Tab(text: 'More', icon: Icon(Icons.menu)),
        ],
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Summary(title: 'Home'),
          Summary(title: 'Search'),
          Summary(title: 'Coming Soon'),
          Summary(title: 'Downloads'),
          Summary(title: 'More'),
        ],
      ),
    );
  }
}

