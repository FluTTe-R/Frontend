import 'package:first_app/log_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordvisible = true;
  bool passwordvisible1 = true;
  final _formfield = GlobalKey<FormState>();
  final username = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passController1 = TextEditingController();

  void senddetails() async {
    final name = username.text;
    final email = emailController.text;
    final password = passController.text;
    final Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
    };
    final responce = await http.post(
      Uri.parse(signup),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    String ress = responce.body;
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Register successful'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (responce.statusCode == 400) {
      print("User Already exists");
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User Already exist'),
        backgroundColor: Colors.red,
      ),
    );
    } else {
      print("server error");
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Server error'),
        backgroundColor: Colors.red,
      ),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        // begin: Alignment.topCenter,
                        colors: [
                      Colors.orange.shade600,
                      Colors.orange.shade400,
                      Colors.orange.shade200
                    ])),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(50),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Text("Create New",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Account",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        )),
                    Container(
                      height: 900,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                        child: Form(
                          key: _formfield,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text("   Username",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: username,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Enter your Username"),
                              ),
                              SizedBox(height: 20),
                              Text("   Email",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "Enter your Email"),
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
                              SizedBox(height: 20),
                              Text("   Password",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
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
                                  }),
                              SizedBox(height: 20),
                              Text("   Confirm Password",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  controller: passController1,
                                  obscureText: passwordvisible1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "Enter your Password",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            passwordvisible1 =
                                                !passwordvisible1;
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
                                  }),
                              SizedBox(height: 35),
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formfield.currentState!.validate()) {
                                      print(username.text);
                                      print(emailController.text);
                                      print(passController.text);
                                      senddetails();
                                      username.clear();
                                      emailController.clear();
                                      passController.clear();
                                      passController1.clear();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange.shade400),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 45),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already account exist?",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
