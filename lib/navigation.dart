import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterconvid19/Helper/config.dart';
import 'package:flutterconvid19/Helper/util.dart';
import 'package:flutterconvid19/Screens/home.dart';
import 'package:flutterconvid19/Screens/hotnews.dart';
import 'package:flutterconvid19/Screens/info.dart';

class BottomXD extends StatefulWidget {
  @override
  State createState() {
    return _BottomXDState();
  }
}

class _BottomXDState extends State<BottomXD> {
  int _selectedIndex = 1;

  final List widgetList = [HotNewsXD(), HomeXD(), InfoXD()];

  _setBottomMenu(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[100],
      statusBarColor: Colors.grey[200],
    ));
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: widgetList[_selectedIndex],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal),
                child: Container(
                  height: SizeConfig.safeBlockVertical * 6.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.safeBlockVertical * 4.2,
                        ),
                        topRight: Radius.circular(
                            SizeConfig.safeBlockVertical * 4.2)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _setBottomMenu(0);
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: _selectedIndex == 0
                                ? CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 18,
                                    child: Icon(
                                      Icons.public,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 4.2,
                                      color: Colors.white,
                                    ))
                                : Icon(
                                    Icons.public,
                                    size: SizeConfig.safeBlockHorizontal * 6.4,
                                  ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setBottomMenu(1);
                          },
                          child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    child: child, scale: animation);
                              },
                              child: _selectedIndex == 1
                                  ? CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 18,
                                      child: Icon(
                                        Icons.home,
                                        size: SizeConfig.safeBlockHorizontal *
                                            4.2,
                                        color: Colors.white,
                                      ))
                                  : Image.asset(
                                      'flags/${countryCodes[selectedIndex].toLowerCase()}.png',
                                      width:
                                          SizeConfig.safeBlockHorizontal * 8.4,
                                    )),
                        ),
                        GestureDetector(
                          onTap: () {
                            _setBottomMenu(2);
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: _selectedIndex == 2
                                ? CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 18,
                                    child: Icon(
                                      Icons.info,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 4.2,
                                      color: Colors.white,
                                    ))
                                : Icon(
                                    Icons.info_outline,
                                    size: SizeConfig.safeBlockHorizontal * 6.4,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
