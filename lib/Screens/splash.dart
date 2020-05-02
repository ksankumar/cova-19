import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterconvid19/Helper/config.dart';
import 'package:flutterconvid19/Transition/scale.dart';
import 'package:flutterconvid19/navigation.dart';

class SplashXD extends StatefulWidget {
  @override
  _SplashXDState createState() => _SplashXDState();
}

class _SplashXDState extends State<SplashXD> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffdd5152),
      statusBarColor: Color(0xffdd5152),
    ));
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xffdd5152),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'gif/heart.gif',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
        () => Navigator.of(context).pushReplacement(
            ScaleRoute(page: BottomXD())));
  }
}
