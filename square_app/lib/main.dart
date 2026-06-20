import 'package:flutter/material.dart';

void main() {
  runApp(SquareApp());
}

class SquareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SquareApp',
      home: SquareHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SquareHome extends StatefulWidget {
  @override
  _SquareHomeState createState() => _SquareHomeState();
}

class _SquareHomeState extends State<SquareHome> {
  TextEditingController txtname = TextEditingController();
  String result = '';

  void calculateSquare() {
    final number = int.tryParse(txtname.text);

    if (number != null) {
      final square = number * number;
      setState(() {
        result = 'Square: $square';
      });
    } else {
      setState(() {
        result = 'Please enter a valid number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Square Calculator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtname,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSquare,
              child: Text("Calculate Square"),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}