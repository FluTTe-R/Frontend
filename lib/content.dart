import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
void main()=>runApp(
  const MaterialApp(
    home: content(),
    debugShowCheckedModeBanner: false,
  )
);
class content extends StatefulWidget {
  const content({super.key});

  @override
  State<content> createState() => _contentState();
} 

class _contentState extends State<content> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("What is Wool"),
        centerTitle: true,
      ),
      body: SfPdfViewer.asset('assets/What is wool.pdf'),

    );
  }
}