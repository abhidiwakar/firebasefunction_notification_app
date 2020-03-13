import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/homepage.dart';
import 'package:flutter/material.dart';

class AppAuth extends StatefulWidget {
  @override
  _AppAuthState createState() => _AppAuthState();
}

class _AppAuthState extends State<AppAuth> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  bool _noError = true;

  _handleError(String error, {bool deleteUser, FirebaseUser user}) async {
    if (deleteUser && user != null) {
      user.delete();
    }
    print(error);
    if (mounted) {
      setState(() {
        _noError = false;
      });
    }
  }

  _authenticate() async {
    FirebaseAuth.instance.signInAnonymously().then((currentUser) async {
      String token = await _messaging.getToken();
      if (token != null && token != '') {
        Firestore.instance
            .collection('users')
            .document(currentUser.user.uid)
            .setData({'fcm': token}).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => MyHomePage(),
            ),
          );
        }).catchError((error) {
          _handleError(
            'INITIAL SETUP FAILED: FAILED TO PUSH TOKEN TO FIRESTORE. Error: $error',
            deleteUser: true,
            user: currentUser.user,
          );
        });
      } else {
        _handleError(
          'INITIAL SETUP FAILED: FAILED TO RETREIVE TOKEN! EMPTY TOKEN RECEIVED.',
          deleteUser: true,
          user: currentUser.user,
        );
      }
    }).catchError((error) {
      _handleError(
        'INITIAL SETUP FAILED: FAILED TO REGISTER USER. Error: $error',
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset(
                  'assets/images/nameless_coder.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
          Container(
            child: _noError
                ? Column(
                    children: <Widget>[
                      Text(
                        'Performing initial setup',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 3.0,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white24,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.warning, color: Colors.yellow),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Initial setup failed!',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
