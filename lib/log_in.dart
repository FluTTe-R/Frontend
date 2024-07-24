import 'package:first_app/config.dart';
import 'package:first_app/f1.dart';
import 'package:flutter/material.dart';
import 'package:first_app/email.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_up.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordvisible = true;
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void sendlogin() async {
    final email = emailController.text;
    final password = passController.text;
    final Map<String, String> data = {
      'email': email,
      'password': password,
    };
    // satajsahaneil
    final responce = await http.post(
        Uri.parse(signin),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(data));
    var ress = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      var myToken = ress['accessToken'];
      var eyToken = ress['refreshToken'];
      print(myToken);
      print(eyToken);
      prefs.setString('accessToken', myToken);
      prefs.setString('refreshToken', eyToken);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    btoken: myToken,
                  )));
      emailController.clear();
      passController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login successful'),
        backgroundColor: Colors.green,
      ),
    );
    } else if (responce.statusCode == 400) {
      print("User doesnot exist");
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User does not exist'),
        backgroundColor: Colors.red,
      ),
    );
    } else if (responce.statusCode == 404) {
      print(ress);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ress.toString()),
        backgroundColor: Colors.red,
      ),
    );
    } else {
      print("Server error!!!");
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
                              Text("Login",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Welcome Back,",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        )),
                    Container(
                      height: 800,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                        child: Form(
                          key: _formfield,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("   Email",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  // autofillHints: [AutofillHints.email],
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      prefixIcon: const Icon(Icons.email),
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
                              const SizedBox(height: 20),
                              const Text("   Password",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
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
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Email()),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blue),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formfield.currentState!.validate()) {
                                      sendlogin();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange.shade400),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 55),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "------------    Or Login With     ---------------",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 55),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipOval(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            "assets/images/google.png",
                                            height: 40,
                                            width: 40,
                                          ))),
                                  ClipOval(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            "assets/images/facebook.png",
                                            height: 40,
                                            width: 40,
                                          ))),
                                  ClipOval(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Image.asset(
                                            "assets/images/twitter.png",
                                            height: 40,
                                            width: 40,
                                          )))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                      child: const Text(
                                        "Sign Up",
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
