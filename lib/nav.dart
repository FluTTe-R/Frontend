import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class NavBar extends StatefulWidget {
  final newtoken;
  const NavBar({Key? key, required this.newtoken}) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String email='';
  String user='';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.newtoken);
    if (jwtDecodedToken != null && jwtDecodedToken.containsKey('email') && jwtDecodedToken.containsKey('name')) {
      setState(() {
        email = jwtDecodedToken['email'];
        user = jwtDecodedToken['name'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:  Text(
              user,
              // 'shiva',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(email,
                style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/profile.jpeg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/back.jpeg",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Friends"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Request"),
            onTap: () {},
            trailing: ClipOval(
                child: Container(
              color: Colors.amber,
              height: 20,
              width: 20,
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
