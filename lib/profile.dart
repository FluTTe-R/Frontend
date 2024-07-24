import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:first_app/orders.dart';
import 'package:first_app/feedback.dart';
import 'package:first_app/search.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:app/contact details.dart';
import 'logindetails.dart';

class profile extends StatefulWidget {
  final atoken;
  const profile({Key? key, required this.atoken}) : super(key: key);
  @override
  State<profile> createState() => _MyprofileState();
}

class _MyprofileState extends State<profile> {
  late String currentAccessToken = '';
  late String currentRefreshToken = '';

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    setState(() {
      currentAccessToken = '';
      currentRefreshToken = '';
    });
    SystemNavigator.pop();
  }

  String email = '';
  String user = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.atoken);
    if (jwtDecodedToken != null &&
        jwtDecodedToken.containsKey('email') &&
        jwtDecodedToken.containsKey('name')) {
      setState(() {
        email = jwtDecodedToken['email'];
        user = jwtDecodedToken['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\t\t\tProfile',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
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
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(children: [
                Stack(children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                          "assets/images/profile.jpeg"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  user,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Complete your profile (1/4) :",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 187, 169, 169))),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Login Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => indetails(
                                                  newtoken: widget.atoken,
                                                )));
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.contact_phone,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Contact Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>contact()));
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  size: 40,
                                ),
                                Text("Set Details"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                                Text("Set Details"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orders()));
                        },
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Row(children: [
                              Icon(
                                Icons.shopping_cart_rounded,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Orders",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))),
                              Icon(Icons.navigate_next),
                            ])),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Row(children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Saved Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))),
                              Icon(Icons.navigate_next),
                            ])),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Row(children: [
                              Icon(
                                Icons.workspaces_outlined,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("My Activity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))),
                              Icon(Icons.navigate_next),
                            ])),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Row(children: [
                              Icon(
                                Icons.settings,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Settings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15))),
                              Icon(Icons.navigate_next),
                            ])),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 400,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Feedback & Information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => feedback()));
                              },
                              child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: Row(children: [
                                    Icon(
                                      Icons.record_voice_over_sharp,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text("Reviews",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Icon(Icons.navigate_next),
                                  ])),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: Row(children: [
                                    Icon(
                                      Icons.fact_check_outlined,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text("Browse FAQs",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Icon(Icons.navigate_next),
                                  ])),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: Row(children: [
                                    Icon(
                                      Icons.policy_rounded,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Terms,Policies and Licenses",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Icon(Icons.navigate_next),
                                  ])),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext) => AlertDialog(
                                          title: const Text(
                                            "Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          content: Text("  Are You Sure?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  _logout();
                                                },
                                                child: const Text("Logout"))
                                          ],
                                        ));
                              },
                              child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  child: Row(children: [
                                    Icon(
                                      Icons.logout_outlined,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text("Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    Icon(Icons.navigate_next),
                                  ])),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
