import 'package:flutter/material.dart';
import 'package:flutterconvid19/Helper/config.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoXD extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InfoXDState();
  }

}

class _InfoXDState extends State<InfoXD> {
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.safeBlockVertical * 7,),
            Center(
              child: Image.asset(
                  'img/logo.png',
                width: SizeConfig.safeBlockHorizontal * 34,
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 3.4,),
            Text(
              'Cova-19',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.safeBlockHorizontal * 10.4,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2
              ),
            ),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                letterSpacing: 0.2,
                color: Colors.grey[700]
              ),
            ),

            SizedBox(height: SizeConfig.safeBlockVertical * 5),
            Text(
              'Stay Home , Stay Safe',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 5.6,
                  fontWeight: FontWeight.w500,
                color: Colors.grey[900],
                letterSpacing: 0.2
              ),
            ),

            SizedBox(height: SizeConfig.safeBlockVertical * 6,),
            Text(
              'For more information, visit -',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 3.4,
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockHorizontal,),
            GestureDetector(
              onTap: (){
                if(mounted) {
                  launch(
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019');
                }
              },
              child: Text(
                'WHO',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                    fontWeight: FontWeight.w500,
                  color: Colors.blue[600],
                  letterSpacing: 1,
                ),
              ),
            ),

            SizedBox(height: SizeConfig.safeBlockVertical * 2,),
            Text(
              'Covid-19 stats sourced from -',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.safeBlockHorizontal * 3.4,
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockHorizontal,),
            GestureDetector(
              onTap: (){
                if(mounted) {
                  launch(
                      'https://thevirustracker.com/');
                }
              },
              child: Text(
                'Coronavirus Tracker',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[600],
                  letterSpacing: 1,
                ),
              ),
            ),

            SizedBox(height: SizeConfig.safeBlockVertical * 2,),
            Text(
              'News sourced from -',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.safeBlockHorizontal * 3.4,
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockHorizontal,),
            GestureDetector(
              onTap: (){
                if(mounted) {
                  launch(
                      'https://newsapi.org/');
                }
              },
              child: Text(
                'News API',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[600],
                  letterSpacing: 1,
                ),
              ),
            ),


            SizedBox(height: SizeConfig.safeBlockVertical * 6.4,),
            Text(
              'Developed by -',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                letterSpacing: 0.2
              ),
            ),
            GestureDetector(
              onTap: (){
                if(mounted){
                  launch('http://quinch.co.in/');
                }
              },
              child: Image.asset(
                  'img/quinch.png',
                width: SizeConfig.safeBlockHorizontal * 34,
              ),
            )
          ],
        ),
      ),
    );
  }

}