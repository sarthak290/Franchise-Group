import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:franchisegroup/main.dart';

class IntroOverboardPage extends StatefulWidget {
  static const routeName = '/IntroOverboardPage';

  @override
  _IntroOverboardPageState createState() => _IntroOverboardPageState();
}

class _IntroOverboardPageState extends State<IntroOverboardPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void gotoScreen(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('seen', true);

    Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Skip clicked"),
            
          ));
          gotoScreen(context);
        },
        finishCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Finish clicked"),
          ));
          gotoScreen(context);
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/images/01.png',
        title: 'Screen 1',
        body: 'The Franchise Group',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/02.png',
        title: 'Screen 2',
        body: 'This a assignment app by The Franchise Group',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/images/03.png',
        title: 'Screen 3',
        body: 'This is the intro slider',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child:
              Image.asset('assets/images/02.png', width: 300.0, height: 300.0),
        ),
        color: Color(0xFF5886d6),
        doAnimateChild: false)
  ];
}
