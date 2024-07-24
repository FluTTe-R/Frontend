import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class indetails extends StatefulWidget {
  final newtoken;
  const indetails({Key? key, required this.newtoken}) : super(key: key);
  @override
  State<indetails> createState() => _indetailsState();
}

class _indetailsState extends State<indetails> {
  bool passwordvisible = true;
  bool passwordvisible1 = true;
  bool passwordvisible2 = true;

  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passController1 = TextEditingController();
  TextEditingController passController2 = TextEditingController();
  TextEditingController otpcontroller =  TextEditingController();

  String email = '';
  String user = '';
  String password = '';

  String generateStars() {
    return '*' * password.length;
  }

  @override
  void sendnewpass() async {
    final newpassword = passController1.text;
    final oldpassword = passController.text;
    final Map<String, String> data = {
      'email': email,
      'newpassword': newpassword,
      'password': oldpassword,
    };
    final responce = await http.post(
      Uri.parse(upany),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    String ress = responce.body;
    if (responce.statusCode == 200) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Password Changed Successfully!',
      );
      passController.clear();
      passController1.clear();
      passController2.clear();
    } else {
      print(responce.body);
    }
  }
  @override
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
      
    } else {
      otpcontroller.clear();
      print("invalid OTP!!!");
    }
  }
  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.newtoken);
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
        title: const Center(
          child: Text(
            "Login Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/128/9069/9069049.png"),
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
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Your Mobile Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Text("7032518043",
                                              style: TextStyle(fontSize: 13)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext) =>
                                                    AlertDialog(
                                                      title: Center(
                                                          child: const Text(
                                                        "Account Authentication",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20),
                                                      )),
                                                      contentPadding:
                                                          EdgeInsets.all(20),
                                                      content: SizedBox(
                                                        height: 250,
                                                        width: double.maxFinite,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Your Current Phone Numberis ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            const Text(
                                                              "7032518043",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            const Text(
                                                              "As a safety precaution ,please input OTP sent to your current Phone Number",
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              height: 50,
                                                              child: TextField(
                                                                decoration: InputDecoration(
                                                                    hintText:
                                                                        'Enter OTP',
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child:
                                                                      const Text(
                                                                    "Resend OTP",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            const Divider(
                                                              thickness: 2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancel")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                Text(
                                                                              "Edit Registered Phone Number",
                                                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                                                            ),
                                                                            contentPadding:
                                                                                EdgeInsets.all(20),
                                                                            content:
                                                                                SizedBox(
                                                                              height: 300,
                                                                              width: double.maxFinite,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const Divider(
                                                                                    thickness: 2,
                                                                                  ),
                                                                                  const Text(
                                                                                    "Your Current Phone Number is",
                                                                                    style: TextStyle(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    "7032518043",
                                                                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  const Text(
                                                                                    "Enter new Number*",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 40,
                                                                                    child: TextFormField(
                                                                                      enableInteractiveSelection: false,
                                                                                      controller: emailcontroller,
                                                                                      keyboardType: TextInputType.emailAddress,
                                                                                      decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        hintText: 'Enter Number',
                                                                                      ),
                                                                                      onChanged: (value) {},
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  Text(
                                                                                    "Enter OTP*",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 40,
                                                                                    child: TextField(
                                                                                      decoration: InputDecoration(
                                                                                        border: OutlineInputBorder(),
                                                                                        hintText: 'Enter OTP',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: Alignment.topRight,
                                                                                    child: TextButton(
                                                                                        onPressed: () {},
                                                                                        child: const Text(
                                                                                          "Resend OTP",
                                                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                        )),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  const Divider(
                                                                                    thickness: 2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: const Text("Cancel")),
                                                                              TextButton(onPressed: () {}, child: const Text("Save")),
                                                                            ],
                                                                          ));
                                                            },
                                                            child: const Text(
                                                                "Verify"))
                                                      ],
                                                    ));
                                          },
                                          child: const Text(
                                            "Edit",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Your Email Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                      height: 30,
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 300,
                                            child: Text(email,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext) =>
                                                      AlertDialog(
                                                        title: Center(
                                                            child: const Text(
                                                          "Account Authentication",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20),
                                                        )),
                                                        contentPadding:
                                                            EdgeInsets.all(20),
                                                        content: SizedBox(
                                                          height: 250,
                                                          width:
                                                              double.maxFinite,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                "Your Current Email Address is ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                email,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              const Text(
                                                                "As a safety precaution ,please input OTP sent to your current email address",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                height: 50,
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          'Enter OTP',
                                                                      border:
                                                                          OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    TextButton(
                                                                        onPressed:() {},
                                                                        child:const Text(
                                                                          "Resend OTP",style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold),)),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              const Divider(
                                                                thickness: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                              onPressed: () {
                                                                setState(() {

                                                                  Navigator.of(context).pop();
                                                                });
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext) =>
                                                                            AlertDialog(
                                                                              title: Text(
                                                                                "Edit Registered Email Address",
                                                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                                                              ),
                                                                              contentPadding: EdgeInsets.all(20),
                                                                              content: SizedBox(
                                                                                height: 320,
                                                                                width: double.maxFinite,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Divider(
                                                                                      thickness: 2,
                                                                                    ),
                                                                                    const Text(
                                                                                      "Your Current Email Address is",
                                                                                      style: TextStyle(
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Text(
                                                                                      "7032518043",
                                                                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    const Text(
                                                                                      "Enter new Email*",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 40,
                                                                                      child: TextFormField(
                                                                                        controller: emailcontroller,
                                                                                        keyboardType: TextInputType.emailAddress,
                                                                                        decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          hintText: 'Enter Email Address',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    Text(
                                                                                      "Enter OTP*",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 40,
                                                                                      child: TextField(
                                                                                        decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          hintText: 'Enter OTP',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: TextButton(
                                                                                          onPressed: () {},
                                                                                          child: const Text(
                                                                                            "Resend OTP",
                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    const Divider(
                                                                                      thickness: 2,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: const Text("Cancel")),
                                                                                TextButton(onPressed: () {}, child: const Text("Save")),
                                                                              ],
                                                                            ));
                                                              },
                                                              child: const Text(
                                                                  "Verify"))
                                                        ],
                                                      ));
                                            },
                                            child: const Text(
                                              "Edit",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Text("*******",
                                              style: TextStyle(fontSize: 13)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                          child: const Text("Edit"),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext) =>
                                                        AlertDialog(
                                                          title: const Center(
                                                              child: Text(
                                                            "Change Password",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          )),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          content: SizedBox(
                                                            height: 380,
                                                            width: double
                                                                .maxFinite,
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const Text(
                                                                    "   Enter Old Password*",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 55,
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          passController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                        ),
                                                                        prefixIcon:
                                                                            Icon(Icons.lock),
                                                                        alignLabelWithHint:
                                                                            false,
                                                                        filled:
                                                                            false,
                                                                      ),
                                                                      validator:
                                                                          (value) {
                                                                        RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                                                            .hasMatch(value!);
                                                                        if (value
                                                                            .isEmpty)
                                                                          return "Enter Password";
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  const Text(
                                                                    "   Enter New Password*",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 55,
                                                                    child: TextFormField(
                                                                        maxLines: 1,
                                                                        controller: passController1,
                                                                        decoration: InputDecoration(
                                                                            prefixIcon: Icon(Icons.lock),
                                                                            border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                            )),
                                                                        validator: (value) {
                                                                          RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                                                              .hasMatch(value!);
                                                                          if (value
                                                                              .isEmpty) {
                                                                            return "Enter Password";
                                                                          } else if (passController1.text.length <
                                                                              6) {
                                                                            return "Password length should be more than 6 characters";
                                                                          }
                                                                        }),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  const Text(
                                                                    "  Confirm New Password*",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 55,
                                                                    child: TextFormField(
                                                                        controller: passController2,
                                                                        decoration: InputDecoration(
                                                                          prefixIcon:
                                                                              Icon(Icons.lock),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                          ),
                                                                          alignLabelWithHint:
                                                                              false,
                                                                          filled:
                                                                              false,
                                                                        ),
                                                                        validator: (value) {
                                                                          RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                                                              .hasMatch(value!);
                                                                          if (value
                                                                              .isEmpty)
                                                                            return "Enter Password";
                                                                          else if (value !=
                                                                              passController1.text) {
                                                                            passController2.clear();
                                                                            return "Invalid Password";
                                                                          }
                                                                        }),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  )
                                                                ]),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    "Cancel")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  sendnewpass();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Save"))
                                                          ],
                                                        ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ]))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Card buildButton({
  required onTap,
  required title,
  required text,
  required leadingIcon,
}) {
  return Card(
    shape: const StadiumBorder(),
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    clipBehavior: Clip.antiAlias,
    elevation: 1,
    child: ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(title ?? ""),
      subtitle: Text(text ?? ""),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
    ),
  );
}
