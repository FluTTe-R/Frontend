import 'package:flutter/material.dart';

class explored extends StatefulWidget {
  const explored({super.key});

  @override
  State<explored> createState() => _exploredState();
}

class _exploredState extends State<explored> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "No Content Found",
        ),
      ),
    );
  }
}
