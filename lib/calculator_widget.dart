import 'package:flutter/material.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String result = '';

  void calculate(String operation) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double calcResult = 0;

    switch (operation) {
      case '+':
        calcResult = num1 + num2;
        break;
      case '-':
        calcResult = num1 - num2;
        break;
      case '*':
        calcResult = num1 * num2;
        break;
      case '/':
        calcResult = num2 != 0 ? num1 / num2 : 0;
        break;
    }

    setState(() {
      result = calcResult.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: num1Controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Number 1'),
        ),
        TextField(
          controller: num2Controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Number 2'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => calculate('+'), child: const Text('+')),
            ElevatedButton(onPressed: () => calculate('-'), child: const Text('-')),
            ElevatedButton(onPressed: () => calculate('*'), child: const Text('*')),
            ElevatedButton(onPressed: () => calculate('/'), child: const Text('/')),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Result: $result',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
