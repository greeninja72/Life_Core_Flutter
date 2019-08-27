import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  String _productId = "LCWF19JL001";
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Post> refresh;

  @override
  initState() {
    super.initState();
    refresh = fetchPost(_productId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Life Core'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 35.0,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                _googleSignIn.signOut();
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<Post>(
                        future: refresh,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int water = snapshot.data.water;

                            return Text(
                              '오늘의 정수량 : \n' + water.toString(),
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      FutureBuilder<Post>(
                        future: refresh,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.water <= 1000) {
                              return Container(
                                width: 80,
                                height: 140,
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 80,
                                  height: 60,
                                  child: Card(color: Colors.lightBlue[200]),
                                ),
                              );
                            } else if (snapshot.data.water > 1000 &&
                                snapshot.data.water <= 2000) {
                              return Container(
                                width: 80,
                                height: 140,
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 80,
                                  height: 100,
                                  child: Card(color: Colors.lightBlue[200]),
                                ),
                              );
                            } else {
                              return Container(
                                width: 80,
                                height: 140,
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 80,
                                  height: 140,
                                  child: Card(color: Colors.lightBlue[200]),
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                      RaisedButton(
                        child: Text('refresh'),
                        onPressed: () {
                          setState(() {
                            refresh = fetchPost(_productId);
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Column(
                    children: <Widget>[
                      FutureBuilder<Post>(
                        future: refresh,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int filter = snapshot.data.filter;

                            return Text(
                              'Filter : \n' + filter.toString(),
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      FutureBuilder<Post>(
                        future: refresh,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.filter <= 2000) {
                              return SizedBox(
                                width: 80,
                                height: 140,
                                child: Card(color: Colors.red),
                              );
                            } else if (snapshot.data.filter > 2000 &&
                                snapshot.data.filter <= 4000) {
                              return SizedBox(
                                width: 80,
                                height: 140,
                                child: Card(color: Colors.yellow),
                              );
                            } else {
                              return SizedBox(
                                width: 80,
                                height: 140,
                                child: Card(color: Colors.green),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                      RaisedButton(
                        child: Text('filter'),
                        onPressed: () {
                          emailSend();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              FutureBuilder<Post>(
                future: refresh,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool notify = snapshot.data.notify;
                    return Text(
                      'SilverCare : ' + notify.toString(),
                      textScaleFactor: 1.0,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
