import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculateevent.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final TextEditingController txtnum1 = TextEditingController();
  final TextEditingController txtnum2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator (BLoC)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Text(
                  "Result = ${state.result}",
                  style: const TextStyle(fontSize: 26),
                );
              },
            ),

            TextField(
              controller: txtnum1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter first number",
              ),
            ),

            TextField(
              controller: txtnum2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter second number",
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final n1 = double.tryParse(txtnum1.text) ?? 0;
                    final n2 = double.tryParse(txtnum2.text) ?? 0;
                    bloc.add(AddEvent(n1, n2));
                  },
                  child: const Text("+"),
                ),

                ElevatedButton(
                  onPressed: () {
                    final n1 = double.tryParse(txtnum1.text) ?? 0;
                    final n2 = double.tryParse(txtnum2.text) ?? 0;
                    bloc.add(SubtractEvent(n1, n2));
                  },
                  child: const Text("-"),
                ),

                ElevatedButton(
                  onPressed: () {
                    final n1 = double.tryParse(txtnum1.text) ?? 0;
                    final n2 = double.tryParse(txtnum2.text) ?? 0;
                    bloc.add(MultiplicationEvent(n1, n2));
                  },
                  child: const Text("×"),
                ),

                ElevatedButton(
                  onPressed: () {
                    final n1 = double.tryParse(txtnum1.text) ?? 0;
                    final n2 = double.tryParse(txtnum2.text) ?? 0;
                    bloc.add(ModolusEvent(n1, n2));
                  },
                  child: const Text("%"),
                ),

                ElevatedButton(
                  onPressed: () {
                    final n1 = double.tryParse(txtnum1.text) ?? 0;
                    final n2 = double.tryParse(txtnum2.text) ?? 0;
                    bloc.add(DivisionEvent(n1, n2));
                  },
                  child: const Text("÷"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}