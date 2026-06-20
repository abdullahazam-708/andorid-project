import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcalculatorapp/calculator_screen.dart';
import 'calculator_riverpod.dart';

void main() {
  runApp(
    ProviderScope(child: CalculatorApp())
  );

}
class CalculatorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "CalculatorApp",
      home: CalculatorScreen(),
    );
  }
}

