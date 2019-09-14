import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifecore_flutter/login/loginPage.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            '계정 정보',
          ),
        ),
        automaticallyImplyLeading: false,
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
          Padding(
            padding: EdgeInsets.all(24.0),
          ),
          Text(
            '제품 명 : LCWF19JL777',
            textScaleFactor: 1.5,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(36.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {},
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(hintText: '사용자 이름'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.language),
                        onPressed: () {},
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(hintText: '국가'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () {},
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(hintText: '전화번호'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.0),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        '확   인',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {},
                      color: Colors.lightBlue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        '뒤로가기',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.lightBlue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        '로그아웃',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
