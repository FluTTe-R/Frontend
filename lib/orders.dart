import 'package:flutter/material.dart';
import 'package:first_app/profile.dart';
import 'package:first_app/search.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: orders(),
    ));

class orders extends StatefulWidget {
  const orders({super.key});

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  // Navigator.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Center(
                child: Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )),
            ],
            bottom: TabBar(labelColor: Colors.black, tabs: [
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Ship',
              ),
              Tab(
                text: 'Completed',
              )
            ]),
          ),
          body: TabBarView(children: [
            Center(
              child: Text('No Orders'),
            ),
            Center(
              child: Text('No Orders'),
            ),
            Center(
              child: Text('No Orders'),
            ),
            Center(
              child: Text('No Orders'),
            )
          ]),
        ));
  }
}
