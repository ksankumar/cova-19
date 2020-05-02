import 'package:flutter/material.dart';
import 'package:flutterconvid19/Screens/splash.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cova-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashXD(),
      debugShowCheckedModeBanner: false,
    );
  }
}
