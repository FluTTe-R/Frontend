import 'package:flutter/material.dart';
import 'package:first_app/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset("assets/images/congrats.png"),
            ),
            SizedBox(height: 40),
            Text(
              "Congrats!!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text("You have successfully changed the password.",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("Please use the new password when logging in.",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login(
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  "Log in Now",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
