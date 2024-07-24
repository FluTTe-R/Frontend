import 'package:first_app/home.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'education.dart';
import 'profile.dart';
import 'sell.dart';

class Home extends StatefulWidget {
  final btoken;
  const Home({Key? key, required this.btoken}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      hoome(atoken: widget.btoken),
      edupd(),
      const sell(),
      profile(atoken: widget.btoken,),
    ];
  }

  int index = 0;
  void onTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: onTapped,
        elevation: 0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cast_for_education_rounded), label: "Edu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_sharp), label: "Sell"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
