import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _subscribed = false;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: ((message) {
        print(message['notification']['title']);
        return;
      }),
      onLaunch: ((message) {
        print(message['notification']['title']);
        return;
      }),
      onResume: ((message) {
        print(message['notification']['title']);
        return;
      }),
    );
  }

  _subscribeToNamelessCoder() async {
    _firebaseMessaging.subscribeToTopic('namelesscoder').then((_) {
      if (mounted) {
        setState(() {
          _subscribed = true;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _subscribed = false;
        });
      }
    });
  }

  _unsubscribeToNamelessCoder() async {
    _firebaseMessaging.unsubscribeFromTopic('namelesscoder').then((_) {
      if (mounted) {
        setState(() {
          _subscribed = false;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _subscribed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Firebase Function'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _subscribed
                ? GestureDetector(
                    onTap: () => _unsubscribeToNamelessCoder(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        color: Colors.white54,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Unsubscribe Nameless Coder',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => _subscribeToNamelessCoder(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        color: Colors.red,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Subscribe Nameless Coder',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 70 / 100,
                color: Colors.blue,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Like this video',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 70 / 100,
                color: Colors.white24,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Share this video',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
