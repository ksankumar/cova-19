import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterconvid19/Helper/config.dart';
import 'package:flutterconvid19/Helper/util.dart';

import 'package:http/http.dart' as http;

class HomeXD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeXDState();
  }
}

class _HomeXDState extends State<HomeXD> {
  Convid convid;

  _selectCountry() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        int _tempSelected = selectedIndex;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(SizeConfig.safeBlockHorizontal * 1.4),
              ),
              title: Text(
                'Choose country',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              content: Container(
                width: SizeConfig.safeBlockHorizontal * 64,
                height: SizeConfig.safeBlockVertical * 50,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: countryCodes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockHorizontal),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempSelected = index;
                            });
                          },
                          child: Container(
                            decoration: index == _tempSelected
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.safeBlockHorizontal * 2),
                                    border: Border.all(
                                        color: Colors.deepOrange[600],
                                        width: SizeConfig.safeBlockHorizontal *
                                            0.1))
                                : BoxDecoration(),
                            padding: index == _tempSelected
                                ? EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 2)
                                : EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'flags/${countryCodes[index].toLowerCase()}.png',
                                  height: SizeConfig.safeBlockHorizontal * 11.4,
                                  width: SizeConfig.safeBlockHorizontal * 11.4,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 2,
                                ),
                                Flexible(
                                  child: Text(
                                    '${countryNames[index]}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                3.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  onPressed: () {
                    selectedIndex = _tempSelected;
                    fetchConvidData(countryCodes[selectedIndex]);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Opacity(
        opacity: _visible ? 0.6 : 1,
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: _visible,
              child: Positioned(
                  top: SizeConfig.screenHeight / 2,
                  left: SizeConfig.screenWidth / 2 - SizeConfig.safeBlockHorizontal * 4.4,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]),
                  )),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                ),
                GestureDetector(
                  onTap: () {
                    _selectCountry();
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        countryNames[selectedIndex],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical,
                      ),
                      Center(
                          child: Card(
                              elevation: SizeConfig.safeBlockHorizontal,
                              child: Image.asset(
                                  'flags/${countryCodes[selectedIndex].toLowerCase()}.png'))),
                      SizedBox(
                        height: SizeConfig.safeBlockHorizontal,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),

                //Total Cases
                SizedBox(height: SizeConfig.safeBlockVertical * 5.4),
                Text(
                  'Total Cases',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 8.6,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 0.2,
                      wordSpacing: 1.4),
                ),
                Text(
                  convid == null
                      ? '0'
                      : convid.totalCase.replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 7.4,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      letterSpacing: 1.4),
                ),

                //New Cases
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Text(
                  'New Cases',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 5.6,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      letterSpacing: 0.2,
                      wordSpacing: 1),
                ),
                Text(
                  convid == null
                      ? '+0'
                      : '+' + convid.newCase.replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 5.4,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[600],
                      letterSpacing: 1.4),
                ),

                //Total Death
                SizedBox(height: SizeConfig.safeBlockVertical * 3.4),
                Text(
                  'Total Death',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 7.6,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 0.2,
                      wordSpacing: 1.4),
                ),
                Text(
                  convid == null
                      ? '0'
                      : convid.totalDeath.replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 6.8,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      letterSpacing: 1.4),
                ),

                //New Death
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Text(
                  'New Death',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      letterSpacing: 0.2,
                      wordSpacing: 1),
                ),
                Text(
                  convid == null
                      ? '+0'
                      : '+' + convid.newDeath.replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 4.8,
                      fontWeight: FontWeight.w500,
                      color: Colors.red[500],
                      letterSpacing: 1.4),
                ),

                //Total Recovered
                SizedBox(height: SizeConfig.safeBlockVertical * 4.4),
                Text(
                  'Total Recovered',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 7.8,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 0.2,
                      wordSpacing: 1.4),
                ),
                Text(
                  convid == null
                      ? '0'
                      : convid.totalRecovered.replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      letterSpacing: 1.4),
                ),

                //Active and Critical Cases
                SizedBox(height: SizeConfig.safeBlockVertical * 3.4),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 6.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Active : ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[900],
                                letterSpacing: 0.2,
                                wordSpacing: 1.4),
                          ),
                          Text(
                            convid == null
                                ? '0'
                                : convid.activeCase
                                    .replaceAllMapped(reg, mathFunc),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: SizeConfig.safeBlockHorizontal * 4.6,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                                letterSpacing: 1.4),
                          ),
                        ],
                      ),
                      Text(
                        '|',
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                            fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Critical : ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[900],
                                letterSpacing: 0.2,
                                wordSpacing: 1.4),
                          ),
                          Text(
                            convid == null
                                ? '0'
                                : convid.criticalCase
                                    .replaceAllMapped(reg, mathFunc),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: SizeConfig.safeBlockHorizontal * 4.6,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                                letterSpacing: 1.4),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 7.2,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  bool _visible;
  @override
  void initState() {
    super.initState();
    fetchConvidData(countryCodes[selectedIndex]);
  }

  fetchConvidData(code) async {
    setState(() {
      _visible = true;
    });
    final response = await http
        .get('https://thevirustracker.com/free-api?countryTotal=$code');

    if (response.statusCode == 200) {
      if(mounted) {
        setState(() {
          convid = Convid.fromJson(json.decode(response.body));
          _visible = false;
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Convid {
  final String totalCase;
  final String newCase;
  final String totalDeath;
  final String newDeath;
  final String totalRecovered;
  final String activeCase;
  final String criticalCase;

  Convid(
      {this.totalCase,
      this.newCase,
      this.totalDeath,
      this.newDeath,
      this.totalRecovered,
      this.activeCase,
      this.criticalCase});

  factory Convid.fromJson(Map<String, dynamic> json) {
    List countryData = json['countrydata'] as List;
    if (countryData == null) {
      return null;
    }
    return Convid(
      totalCase: countryData[0]['total_cases'].toString(),
      newCase: countryData[0]['total_new_cases_today'].toString(),
      totalDeath: countryData[0]['total_deaths'].toString(),
      newDeath: countryData[0]['total_new_deaths_today'].toString(),
      totalRecovered: countryData[0]['total_recovered'].toString(),
      activeCase: countryData[0]['total_active_cases'].toString(),
      criticalCase: countryData[0]['total_serious_cases'].toString(),
    );
  }
}
