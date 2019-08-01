import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            )
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
                      SizedBox(
                        width: 100,
                        height: 160,
                        child: Card(
                          color: Colors.green,
                        ),
                      ),
                      RaisedButton(
                        onPressed: null,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Water Size',
                        textScaleFactor: 2.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        'Status: Great',
                        textScaleFactor: 1.5,
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              RaisedButton(
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
