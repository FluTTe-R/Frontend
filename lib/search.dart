import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title:SizedBox(
          height: 55,
        width: (double.infinity),
        child: TextField(
          decoration: InputDecoration(
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            prefixIcon: const Icon(Icons.search),
            suffixIcon:
                IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
            hintText: "Search..."
          ),
        ),
      )),
    );
  }
}
