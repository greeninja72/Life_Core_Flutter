import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:lifecore_flutter/home.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final GoogleSignIn si = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('로그아웃'),

              // logout
              onPressed: () {
                FirebaseAuth.instance.signOut();
                si.signOut();
              },
            ),
            RaisedButton(
              child: Text('로그아웃'),

              // logout
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
