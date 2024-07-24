import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Price extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<Price> {
  final TextEditingController _dateController = TextEditingController();
  String _predictedPrice = '';

  Future<void> _predictPrice() async {
    String date = _dateController.text;

    final responce = await http.post(
        Uri.parse('http://192.168.210.209:5000/predict_price'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'date': date}));

    if (responce.statusCode == 200) {
      Map<String, dynamic> data = json.decode(responce.body);
      setState(() {
        _predictedPrice = data['predicted_price'].toString();
      });
    } else {
      setState(() {
        _predictedPrice = 'Error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Enter Date'),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: _predictPrice,
              child: Text('Predict Price'),
            ),
            SizedBox(height: 50.0),
            Text(
              'Predicted Price:  Rs $_predictedPrice per Kg',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
