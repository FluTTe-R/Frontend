import 'package:first_app/config.dart';
import 'package:flutter/material.dart';
import 'package:first_app/otp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Email extends StatefulWidget {
    const Email({super.key});
  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void sendemail() async {
    final email = emailController.text;
    final Map<String, String> data = {
      'email': email,
    };
    final response = await http.post(
      Uri.parse(sendotp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    final responce = response;
    String ress = responce.body;
    print(responce.body);
    print(responce.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Image.asset("assets/images/email.png"),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: _formfield,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter your e-mail address to receive",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Text(
                    "a verification code",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Email Address",
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return "Enter Email";
                        } else if (!emailValid) {
                          return "Enter Valid Email";
                        }
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formfield.currentState!.validate()) {
                          sendemail();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => OTP(email:emailController.text)),
                          );
                        } else {
                          print("Invalid Email ID");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: Text(
                        "Send OTP",
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
        ),
      ],
    ));
  }
}
