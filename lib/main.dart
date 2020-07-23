import 'package:flutter/material.dart';
import 'package:flutterapp3/views/home.dart';
import 'helper/authenticate.dart';
import 'helper/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // bool _isUserLoggedIn = false;

 /* @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        _isUserLoggedIn = value;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage()  // (_isUserLoggedIn??false) ? HomePage() : Authenticate(),
    );
  }
}
