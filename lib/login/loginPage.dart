import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Core',
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('images/logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(
                  '라이프코어 살균수기',
                  textScaleFactor: 2.0,
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.all(72.0),
                ),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    _handleSignIn().then(
                      (user) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(user),
                          ),
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(48.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // backButton Error
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
    return user;
  }
}
