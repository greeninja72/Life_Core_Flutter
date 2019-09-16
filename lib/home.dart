import 'package:flutter/material.dart';
import 'package:lifecore_flutter/setting/setting.dart';
import 'post.dart';
import 'email.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String productId = "LCWF19JL777";

  var now = DateTime.now();
  var year = DateTime.now().year.toString() + '년 ';
  var month = DateTime.now().month.toString() + '월 ';
  var day = DateTime.now().day.toString() + '일 ';

  String weekday() {
    switch (DateTime.now().weekday) {
      case 0:
        return '일';
        break;
      case 1:
        return '월';
        break;
      case 2:
        return '화';
        break;
      case 3:
        return '수';
        break;
      case 4:
        return '목';
        break;
      case 5:
        return '금';
        break;
      case 6:
        return '토';
        break;
      default:
    }
  }

  Future<Post> refresh;

  @override
  initState() {
    super.initState();
    refresh = fetchPost(productId);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "오늘의 살균수 사용량",
              textScaleFactor: 0.9,
            ),
            content: FutureBuilder<Post>(
              future: refresh,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int water = snapshot.data.water;
                  double waterdouble = water / 100;

                  return Text(
                    '오늘의 살균수 사용량은 ' +
                        waterdouble.roundToDouble().toString() +
                        'L 입니다.\n세계 보건기구가 제안하는 하루 물 섭취 권장량은 1.5 ~ 2.0L입니다.',
                    textScaleFactor: 1.05,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return Text('');
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('닫기'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '라이프코어 살균수기',
            textScaleFactor: 1.25,
          ),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.orange,
            height: 3.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Today'),
                Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Text(
                  year + month + day + weekday() + '요일',
                  textScaleFactor: 1.5,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: Image(
                              image: AssetImage('images/water.png'),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(28.0),
                              ),
                              SizedBox(
                                width: 130,
                                child: FutureBuilder<Post>(
                                  future: refresh,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int water = snapshot.data.water;
                                      double waterDouble = water / 100;

                                      return Text(
                                        waterDouble.roundToDouble().toString() +
                                            'L',
                                        textScaleFactor: 1.5,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    // By default, show a loading spinner.
                                    return Text('');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        '오늘의 살균수 사용량',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      OutlineButton(
                        child: Text(
                          '상세보기 >',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          _showDialog();
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            height: 130,
                            child: Image(
                              image: AssetImage('images/filter.png'),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(24.0),
                              ),
                              SizedBox(
                                width: 130,
                                child: FutureBuilder<Post>(
                                  future: refresh,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int filter = snapshot.data.filter;
                                      double filterDouble = filter / 4000 * 100;

                                      return Text(
                                        filterDouble
                                                .roundToDouble()
                                                .toString() +
                                            '%',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.25,
                                        style: TextStyle(
                                            color: Colors.tealAccent[400]),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    // By default, show a loading spinner.
                                    return Text('');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        '필터잔량',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      OutlineButton(
                        child: Text(
                          '새로고침 >',
                          style: TextStyle(color: Colors.tealAccent[400]),
                        ),
                        onPressed: () {
                          setState(() {
                            refresh = fetchPost(productId);
                          });
                        },
                        borderSide: BorderSide(color: Colors.tealAccent[400]),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: Image(
                          image: AssetImage('images/subcribe.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      RaisedButton(
                        child: Text(
                          '필터교체 >',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          emailSend();
                        },
                        color: Colors.lightBlue[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: Image(
                          image: AssetImage('images/setting.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      RaisedButton(
                        child: Text(
                          '설정 >',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Setting()));
                        },
                        color: Colors.lightBlue[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // body: Column(
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(16.0),
      //     ),
      //     Text('Today'),
      //     Padding(
      //       padding: EdgeInsets.all(4.0),
      //     ),
      //     Text(
      //       year + month + day + weekday() + '요일',
      //       textScaleFactor: 1.5,
      //     ),
      //     Padding(
      //       padding: EdgeInsets.all(24.0),
      //     ),
      //     Container(
      //       child: Column(
      //         children: <Widget>[
      //           Stack(
      //             children: <Widget>[
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: <Widget>[
      //                   Column(
      //                     children: <Widget>[
      //                       Image(
      //                         image: AssetImage('images/water.png'),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.all(12.0),
      //                       ),
      //                       Text(
      //                         '오늘의 살균수 사용량',
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.all(12.0),
      //                       ),
      //                       OutlineButton(
      //                         child: Text(
      //                           '상세보기 >',
      //                           style: TextStyle(color: Colors.grey),
      //                         ),
      //                         onPressed: () {
      //                           _showDialog();
      //                         },
      //                         color: Colors.white,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(30.0),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Column(
      //                     children: <Widget>[
      //                       Image(
      //                         image: AssetImage('images/filter.png'),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.all(12.0),
      //                       ),
      //                       Text(
      //                         '필터잔량',
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.all(12.0),
      //                       ),
      //                       OutlineButton(
      //                         child: Text(
      //                           '새로고침 >',
      //                           style: TextStyle(color: Colors.tealAccent[400]),
      //                         ),
      //                         onPressed: () {
      //                           setState(() {
      //                             refresh = fetchPost(productId);
      //                           });
      //                         },
      //                         borderSide:
      //                             BorderSide(color: Colors.tealAccent[400]),
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(30.0),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Column(
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: EdgeInsets.all(20.0),
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: <Widget>[
      //                       SizedBox(
      //                         height: 60,
      //                         width: 160,
      //                         child: Card(
      //                           color: Colors.transparent,
      //                           elevation: 0.0,
      //                           child: FutureBuilder<Post>(
      //                             future: refresh,
      //                             builder: (context, snapshot) {
      //                               if (snapshot.hasData) {
      //                                 int water = snapshot.data.water;
      //                                 double waterDouble = water / 100;

      //                                 return Text(
      //                                   waterDouble.roundToDouble().toString() +
      //                                       'L',
      //                                   textScaleFactor: 1.5,
      //                                   textAlign: TextAlign.center,
      //                                   style: TextStyle(color: Colors.white),
      //                                 );
      //                               } else if (snapshot.hasError) {
      //                                 return Text("${snapshot.error}");
      //                               }
      //                               // By default, show a loading spinner.
      //                               return Text('');
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.all(4.0),
      //                       ),
      //                       SizedBox(
      //                         height: 80,
      //                         width: 80,
      //                         child: Card(
      //                           color: Colors.transparent,
      //                           elevation: 0.0,
      //                           child: FutureBuilder<Post>(
      //                             future: refresh,
      //                             builder: (context, snapshot) {
      //                               if (snapshot.hasData) {
      //                                 int filter = snapshot.data.filter;
      //                                 double filterDouble = filter / 4000 * 100;

      //                                 return Text(
      //                                   filterDouble
      //                                           .roundToDouble()
      //                                           .toString() +
      //                                       '%',
      //                                   textAlign: TextAlign.center,
      //                                   textScaleFactor: 1.25,
      //                                   style: TextStyle(
      //                                       color: Colors.tealAccent[400]),
      //                                 );
      //                               } else if (snapshot.hasError) {
      //                                 return Text("${snapshot.error}");
      //                               }
      //                               // By default, show a loading spinner.
      //                               return Text('');
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Padding(
      //             padding: EdgeInsets.all(24.0),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: <Widget>[
      //               Column(
      //                 children: <Widget>[
      //                   Stack(
      //                     children: <Widget>[
      //                       Image(
      //                         image: AssetImage('images/subcribe.png'),
      //                       ),
      //                       Container(
      //                         height: 90,
      //                         width: 75,
      //                         alignment: Alignment.bottomCenter,
      //                         child: SizedBox(
      //                           height: 35,
      //                           width: 75,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.all(8.0),
      //                   ),
      //                   RaisedButton(
      //                     child: Text(
      //                       '필터교체 >',
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                     onPressed: () {
      //                       emailSend();
      //                     },
      //                     color: Colors.lightBlue[200],
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(30.0),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Column(
      //                 children: <Widget>[
      //                   Image(
      //                     image: AssetImage('images/setting.png'),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.all(8.0),
      //                   ),
      //                   RaisedButton(
      //                     child: Text(
      //                       '설정 >',
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                     onPressed: () {
      //                       Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                               builder: (context) => Setting()));
      //                     },
      //                     color: Colors.lightBlue[200],
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(30.0),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
