import 'package:flutter/material.dart';
import 'package:first_app/newpass.dart';
import 'package:pinput/pinput.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class OTP extends StatefulWidget {
  final String email; // Add a parameter to receive the email
  const OTP({Key? key, required this.email})
      : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final otpcontroller = TextEditingController();
  late String email;

  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  void sendotp() async {
    final otp = otpcontroller.text;
    final Map<String, String> data = {
      'email': email,
      'otp': otp,
    };
    final responce = await http.post(
      Uri.parse(verify),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    String ress = responce.body;
    if (responce.statusCode == 200) {
      print("OTP verified");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => New(email:email)),
      );
    } else {
      otpcontroller.clear();
      print("invalid OTP!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Verification Code",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "We have sent the verification",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const Text("code to your email address",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Pinput(
                    controller: otpcontroller,
                    length: 4,
                    defaultPinTheme: PinTheme(
                        height: 68,
                        width: 64,
                        textStyle: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Didn't receive the OTP?",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              ]),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    sendotp();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
