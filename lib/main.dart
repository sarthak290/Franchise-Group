import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:franchisegroup/screens/intro.dart';
import 'package:franchisegroup/screens/signUp.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstSeen = false;

   @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen)
      setState(() {
        isFirstSeen = true;
      });
    else {
      setState(() {
        isFirstSeen = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Franchise Group',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: !isFirstSeen ? IntroOverboardPage():Auth()
    
      ,
    );
  }
}

