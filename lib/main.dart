import 'package:first_app/config.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'log_in.dart';
import 'f1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return Home(btoken: snapshot.data!);
            } else {
              return Login();
            }
          }
        },
      ),
    );
  }

  Future <String?> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? atoken = prefs.getString('accessToken');
    String? rtoken = prefs.getString('refreshToken');

    if (atoken != null && !JwtDecoder.isExpired(atoken)) {
      return atoken; 
    } else {
      String? newAccessToken = await generateAccessToken(rtoken);
      if (newAccessToken != null) {
        prefs.setString('accessToken', newAccessToken);
        return newAccessToken; 
      } else {
        prefs.remove('accessToken'); 
        return null;
      }
    }
  }

  Future<String?> generateAccessToken(String? refreshToken) async {
    final Map<String, String?> data = {
      'refreshToken':refreshToken,
    };
    try {
      final response = await http.post(
        Uri.parse(refreshtoken),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(data),
      );
      print('Refresh Token: $refreshToken');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final newAccessToken = responseData['accessToken'];
        return newAccessToken;
      } else {
        print('Failed to refresh token. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }
}
