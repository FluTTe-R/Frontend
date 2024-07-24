import 'package:first_app/f1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'IntroScreen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() => runApp(MaterialApp(
      home: splashscreen(),
      debugShowCheckedModeBanner: false,
    ));

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? atoken = prefs.getString('accessToken');
    if (atoken != null && !JwtDecoder.isExpired(atoken)) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home(btoken: atoken,)));
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Farm to fabric.png',
              height: 500,
            ),
          ],
        ),
      ),
    );
  }
}
