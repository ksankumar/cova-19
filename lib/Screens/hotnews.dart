import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterconvid19/Helper/config.dart';
import 'package:flutterconvid19/Helper/util.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HotNewsXD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotNewsXDState();
  }
}

class NewsList {
  final List<News> news;

  NewsList({this.news});

  factory NewsList.fromJson(Map<String, dynamic> json) {
    List articles = json['articles'] as List;
    if (articles == null) {
      return null;
    }
    List<News> tempList = [];
    for (int i = 0; i < articles.length; i++) {
      News news = News(
          image: articles[i]['urlToImage'].toString(),
          title: articles[i]['title'].toString(),
          description: articles[i]['description'].toString(),
          publisher: articles[i]['source']['name'].toString(),
          time: articles[i]['publishedAt'].toString(),
          url: articles[i]['url']);
      tempList.add(news);
    }
    return NewsList(
      news: tempList,
    );
  }
}

class News {
  final String image;
  final String title;
  final String description;
  final String publisher;
  final String time;
  final String url;

  News(
      {this.image,
      this.title,
      this.description,
      this.publisher,
      this.time,
      this.url});
}

class _HotNewsXDState extends State<HotNewsXD> {

  bool _visible;
  List<News> news;

  @override
  void initState() {
    super.initState();
    news = null;
    if(selectedIndex == 102){
      fetchNewsData(newsUrlIndia);
    }else{
      fetchNewsData(newsUrlOthers);
    }
  }

  fetchNewsData(url) async {
    setState(() {
      _visible = true;
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      NewsList newsList = NewsList.fromJson(json.decode(response.body));
      if(mounted) {
        setState(() {
          _visible = false;
          news = newsList.news;
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  String converttime(time){
    String temp = time.split('T')[1];
    String tempTime = temp.substring(0,temp.length-4);
    if(selectedIndex == 102) {
      int tempHour = int.parse(tempTime.substring(0, 2)) + 5;
      int tempMin = int.parse(tempTime.substring(3, 5)) + 30;

      if (tempMin >= 60) {
        tempHour += 1;
        tempMin -= 60;
      }
      if (tempHour >= 24) {
        tempHour = 0;
      }

      String finalTime = '';
      String finalHour = '';
      String finalMin = '';

      if (tempHour
          .toString()
          .length < 2) {
        finalHour = '0' + tempHour.toString();
      } else {
        finalHour = tempHour.toString();
      }

      if (tempMin
          .toString()
          .length < 2) {
        finalMin = '0' + tempMin.toString();
      } else {
        finalMin = tempMin.toString();
      }

      if (tempHour >= 12) {
        finalTime = finalHour + ':' + finalMin + ' PM';
      } else {
        finalTime = finalHour + ':' + finalMin + ' AM';
      }

      return finalTime;
    }else{
      String finalTime = '';
      finalTime = tempTime + ' GMT';
      return finalTime;
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Failed to  launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 7.8,
                  ),
                  Text(
                    'News',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: SizeConfig.safeBlockHorizontal * 5.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: news == null ? 0 : news.length,
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 3.4,
                                bottom: SizeConfig.safeBlockVertical * 3.4,
                                left: SizeConfig.safeBlockHorizontal * 6,
                                right: SizeConfig.safeBlockHorizontal * 6),
                            child: Container(
                              color: Colors.grey[400],
                              height: SizeConfig.safeBlockHorizontal * 0.1,
                            ),
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 3.4,
                                right: SizeConfig.safeBlockHorizontal * 2.4),
                            child: GestureDetector(
                              onTap: (){
                                _launchURL(news[index].url);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.safeBlockHorizontal * 1.4),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'img/news.png',
                                      image: news[index].image,
                                      width: SizeConfig.safeBlockHorizontal * 24,
                                      height: SizeConfig.safeBlockHorizontal * 22,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.safeBlockHorizontal * 2,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //title
                                        Text(
                                          news[index].title,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3.2,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        //description
                                        SizedBox(
                                          height: SizeConfig.safeBlockHorizontal,
                                        ),
                                        Text(
                                          news[index].description,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  SizeConfig.safeBlockHorizontal *
                                                      2.4,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700]),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.safeBlockHorizontal *
                                              1.8,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.public,
                                              size:
                                                  SizeConfig.safeBlockHorizontal *
                                                      3,
                                              color: Colors.grey[800],
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.safeBlockHorizontal,
                                            ),
                                            Text(
                                              news[index].publisher,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      2.2,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.safeBlockHorizontal *
                                                      4.4,
                                            ),
                                            Icon(
                                              Icons.access_time,
                                              size:
                                                  SizeConfig.safeBlockHorizontal *
                                                      3,
                                              color: Colors.grey[900],
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.safeBlockHorizontal,
                                            ),
                                            Text(
                                              converttime(news[index].time),
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      2.2,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.4),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 7.2,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
