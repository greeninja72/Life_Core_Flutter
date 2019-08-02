import 'package:flutter/material.dart';
import 'post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _productId = "test1111";

  Future<Post> refresh;

  @override
  initState() {
    super.initState();
    refresh = fetchPost(_productId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeCore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Life Core'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.email,
                size: 40.0,
              ),
              onPressed: () {},
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
                    children: <Widget>[
                      FutureBuilder<Post>(
                        future: refresh,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.water <= 2000) {
                              return SizedBox(
                                width: 100,
                                height: 160,
                                child: Card(color: Colors.red),
                              );
                            } else if (snapshot.data.water > 2000 &&
                                snapshot.data.water <= 4000) {
                              return SizedBox(
                                width: 100,
                                height: 160,
                                child: Card(color: Colors.yellow),
                              );
                            } else {
                              return SizedBox(
                                width: 100,
                                height: 160,
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
                            int water = snapshot.data.water;

                            return Text(
                              'Water Size : ' + water.toString(),
                              textScaleFactor: 2.0,
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
                            bool notify = snapshot.data.notify;
                            return Text(
                              'Status : ' + notify.toString(),
                              textScaleFactor: 2.0,
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
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              RaisedButton(
                child: Text('filter'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
