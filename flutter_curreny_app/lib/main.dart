import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: CurrencyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CurrencyHome extends StatefulWidget {
  @override
  CurrencyState createState() => CurrencyState();
}

class CurrencyState extends State<CurrencyHome> {
  TextEditingController txtAmount = TextEditingController();

  Map<String, dynamic>? rates;
  Map<String, double> convertedAmount = {};

  List<String> targetCurr = [
    'SAR',
    'KWD',
    'GBP',
    'EUR',
    'PKR',
    'CNY',
    'AED',
    'INR',
    'JPY',
    'MYR'
  ];

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  // 🔹 Fetch API Data
  Future<void> fetchRates() async {
    const api =
        "https://api.exchangerate-api.com/v4/latest/USD"; // free API

    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        rates = data['rates'];
      });
    } else {
      print("Failed to load rates");
    }
  }

  // 🔹 Convert Currency
  void convertCurrency() {
    if (rates == null) return;

    final amount = double.tryParse(txtAmount.text);
    if (amount == null) return;

    Map<String, double> results = {};

    for (var curr in targetCurr) {
      if (rates![curr] != null) {
        results[curr] = amount * rates![curr];
      }
    }

    setState(() {
      convertedAmount = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: txtAmount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount (USD)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text("Convert"),
            ),
            SizedBox(height: 20),

            // 🔹 Show Results
            Expanded(
              child: ListView(
                children: convertedAmount.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text(entry.value.toStringAsFixed(2)),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}