import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() => runApp(MaterialApp(
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    ));

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
              titleWidget: Text(
                "Farmer",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              body:
                  "Nurturing nature's warmth, wool farmers weave a tapestry of sustainability, where every fleece tells a story of care, commitment, and the timeless artistry of the land.",
              image: Image.asset(
                "assets/images/screen1.jpg",
                height: 260,
                width: 400,
              )),
          PageViewModel(
              titleWidget: Text(
                "Warehouse",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              body:
                  "Warehouses are the backstage heroes of commerce, storing and organizing goods until they're ready to take center stage in the hands of customers",
              image: Image.asset(
                "assets/images/screen2.jpg",
                height: 250,
                width: 400,
              )),
          PageViewModel(
              titleWidget: Text(
                "Buyer",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              body:
                  "Buyers aren't just customers; they're the architects of choice, shaping their world with every purchase and crafting stories from the products they bring into their lives",
              image: Image.asset(
                "assets/images/screen3.jpg",
                height: 250,
                width: 400,
              )),
        ],
        onDone: () {
          // Navigator.pushNamed(context, "MyApp");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        onSkip: () {
          // Navigator.pushNamed(context, "MyApp");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        next: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        done: Text(
          "Done",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: Colors.black,
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
