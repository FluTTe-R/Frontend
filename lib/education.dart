import 'package:flutter/material.dart';
import 'contents.dart';
import 'explored.dart';
import 'uploaded.dart';
void main()=>runApp(
  const MaterialApp
  (
    debugShowCheckedModeBanner: false,
    home: edupd(),
  )
);
class edupd extends StatefulWidget {
  const edupd({super.key});

  @override
  State<edupd> createState() => _edupdState();
}

class _edupdState extends State<edupd> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Wool Education"),),
          actions: [
            IconButton.filled(onPressed: (){}, icon:const Icon(Icons.search_sharp))
          ],
          backgroundColor: Colors.orangeAccent,
          bottom: TabBar(tabs: [Tab(text: 'Contents',),
                                Tab(text: 'Explored',),
                                Tab(text: 'Uploaded',),
          ]),
        ),
        body: const TabBarView(children: [
          contents(),
          uploaded(),
          explored(),
        ]),
      ),
    );
  }
}
