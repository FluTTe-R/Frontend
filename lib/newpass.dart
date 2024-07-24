import 'package:flutter/material.dart';
import 'package:first_app/verify.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class New extends StatefulWidget {
  final String email; // Add a parameter to receive the email
  const New({Key? key, required this.email})
      : super(key: key);
  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  bool passwordvisible = true;
  bool passwordvisible1 = true;
  final _formfield = GlobalKey<FormState>();
  final passController = TextEditingController();
  final passController1 = TextEditingController();
  late String email;

  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  void sendnewpass() async {
    final newpassword = passController.text;
    final Map<String, String> data = {
      'email': email,
      'newpassword': newpassword,
    };
    final responce = await http.post(
      Uri.parse(update),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    String ress = responce.body;
    if (responce.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Verify()),
        );
    } else {
      print(responce.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: 900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset("assets/images/key.png"),
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
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("   New Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: passController,
                          obscureText: passwordvisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter your Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordvisible = !passwordvisible;
                                  });
                                },
                                icon: Icon(passwordvisible
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            alignLabelWithHint: false,
                            filled: false,
                          ),
                          validator: (value) {
                            RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                .hasMatch(value!);

                            if (value.isEmpty) {
                              return "Enter Password";
                            } else if (passController.text.length < 6) {
                              return "Password length should be more than 6 characters";
                            }
                          }
                          ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("   Confirm Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          obscureText: passwordvisible1,
                          controller: passController1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter your Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordvisible1 = !passwordvisible1;
                                  });
                                },
                                icon: Icon(passwordvisible1
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            alignLabelWithHint: false,
                            filled: false,
                          ),
                          validator: (value) {
                            RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                .hasMatch(value!);
                            if (value.isEmpty)
                              return "Enter Password";
                            else if (value != passController.text) {
                              passController1.clear();
                              return "Invalid Password";
                            }
                          }
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formfield.currentState!.validate()) {
                              print(passController.text);
                              sendnewpass();
                              passController.clear();
                              passController1.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
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
            ),
          ],
        ),
      ),
    ));
  }
}
