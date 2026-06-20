import 'package:flutter/material.dart';

void main() {
  runApp(NavigatorApp());
}

class NavigatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluterNavigatorApp',
      home: HomeScreen(),
      routes: {
        'screen2': (context) => CalculatorScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen1'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'screen2');
          },
          child: Container(
           // padding: EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //   color: Colors.pinkAccent,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Text(
              'tap here to open calculator',
              //textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26),
            ),
          ),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController txtnum1 = TextEditingController();
  TextEditingController txtnum2 = TextEditingController();

  String result = '';

  void calculate(String ope) {
    double? num1 = double.tryParse(txtnum1.text);
    double? num2 = double.tryParse(txtnum2.text);

    if (num1 == null || num2 == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double res;

    switch (ope) {
      case '+':
        res = num1 + num2;
        break;
      case '-':
        res = num1 - num2;
        break;
      case '*':
        res = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          setState(() {
            result = "Cannot divide by zero";
          });
          return;
        }
        res = num1 / num2;
        break;
      default:
        res = 0;
    }

    setState(() {
      result = "Result: $res";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtnum1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter first number"),
            ),
            TextField(
              controller: txtnum2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter second number"),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: Text('/'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}