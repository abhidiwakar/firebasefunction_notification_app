import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notifications/auth.dart';
import 'package:firebase_notifications/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase PushNotification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialCheck(),
    );
  }
}

class InitialCheck extends StatefulWidget {
  @override
  _InitialCheckState createState() => _InitialCheckState();
}

class _InitialCheckState extends State<InitialCheck> {
  checkCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => MyHomePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => AppAuth(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
      ),
    );
  }
}
