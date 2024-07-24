import 'package:flutter/material.dart';

class sell extends StatefulWidget {
  const sell({super.key});

  @override
  State<sell> createState() => _sellState();
}

class _sellState extends State<sell> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: 
      Center(
        child:Text("No items"),
      ),
    );
  }
}