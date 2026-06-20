import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "calculator_riverpod.dart";
// statelesswidget,ConsumerStatefullWiget
//specficaly design for riverpod
class CalculatorScreen extends ConsumerWidget {
  TextEditingController txtnum1= TextEditingController();
  TextEditingController txtnum2= TextEditingController();
   @override
  Widget build(BuildContext context, WidgetRef ref ){
     final result = ref.watch(calculatorProvider);//why we use it
     final calculato= ref.read(calculatorProvider.notifier);//why we use it
     return Scaffold(
       appBar: AppBar(title: Text("enter_date")),
       body: Padding(
           padding: EdgeInsets.all(14.5),
         child: Column(
          children: [
            TextField(
              controller: txtnum1,
              decoration: InputDecoration(labelText: "enter first number"),
            ),
            TextField(
              controller: txtnum2,
              decoration: InputDecoration(labelText: 'enter second number2'),

            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed:(){
              calculato.addition(txtnum1.text,txtnum2.text);
            },child: Text("+")),
            ElevatedButton(onPressed:(){
              calculato.subtract(txtnum1.text,txtnum2.text);
            },child: Text("-")),
            ElevatedButton(onPressed:(){
              calculato.multiplication(txtnum1.text,txtnum2.text);
            },child: Text("*")),
            ElevatedButton(onPressed:(){
              calculato.division(txtnum1.text,txtnum2.text);
            },child: Text("/")),
            ElevatedButton(onPressed:(){
              calculato.modolus(txtnum1.text,txtnum2.text);
            },child: Text("/")),
            Text("Result: $result ",
              style: TextStyle(fontSize: 20),
            ),
          ],
         ),
       ),
     );
   }
}