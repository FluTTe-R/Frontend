import 'package:first_app/warehouse.dart';
import 'news.dart';
import 'price.dart';
import 'package:flutter/material.dart';
import 'nav.dart';
import 'search.dart';

class hoome extends StatefulWidget {
  final atoken;
  const hoome({Key? key, required this.atoken}) : super(key: key);
  @override
  State<hoome> createState() => _homeState();
}

class _homeState extends State<hoome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(newtoken: widget.atoken),
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: const Color(0xFFFFE45E),
                // color: Colors.yellow,
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: TextButton(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 100,
                              child: Image.asset("assets/images/news.png")),
                          const Text(
                            "News",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ]),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => News()));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      color: Colors.indigo.shade100,
                      child: SizedBox(
                        height: 200,
                        child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  child:
                                      Image.asset("assets/images/trend.png")),
                              const Text(
                                "Trends",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      color: const Color(0xFFBAD1CD),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        height: 200,
                        child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  child: Image.asset(
                                      "assets/images/warehouse.png")),
                              const Text(
                                "Warehouse",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NearbyPlacesList()));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      color: const Color(0xFFF2D1C9),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        height: 200,
                        child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  child:
                                      Image.asset("assets/images/quality.png")),
                              const Text(
                                "Quality",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      // color: Color.fromARGB(255, 172, 201, 148),
                      color: const Color(0xFFDEF4C6),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        height: 200,
                        child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  child:
                                      Image.asset("assets/images/profits.png")),
                              const Text(
                                "Prices",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Price()));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
