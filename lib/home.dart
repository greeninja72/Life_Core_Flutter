import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifecore_flutter/login/loginPage.dart';
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
  String productId = "LCWF19JL001";

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '       라이프코어 살균수기',
            textScaleFactor: 1.25,
          ),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.orange,
            height: 3.0,
          ),
          preferredSize: Size.fromHeight(16.0),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.refresh,
        //       size: 30.0,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         refresh = fetchPost(productId);
        //       });
        //     },
        //   ),
        // ],
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('새로고침'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('로그아웃'),
                value: 2,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Text('Today'),
          Padding(
            padding: EdgeInsets.all(4.0),
          ),
          Text(
            year + month + day + weekday() + '요일',
            textScaleFactor: 1.5,
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/water.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                            ),
                            Text(
                              '오늘의 살균수 사용량',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/filter.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                            ),
                            Text(
                              '필터잔량',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 180.0,
                          width: 10.0,
                          child: Card(
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                              width: 160,
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
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
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
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
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/subcribe.png'),
                            ),
                            Container(
                              height: 90,
                              width: 75,
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 35,
                                width: 75,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        RaisedButton(
                          child: Text(
                            '필터구독 >',
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
                    Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/setting.png'),
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
                          // logout
                          // onPressed: () {
                          //   FirebaseAuth.instance.signOut();
                          //   _googleSignIn.signOut();
                          // },
                          color: Colors.lightBlue[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
