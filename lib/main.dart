import 'package:flutter/material.dart';

void main() {
  runApp(UnitConversionApp());
}

class UnitConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedConversion = 'Length';
  String _result = '';

  final Map<String, String> conversionTypes = {
    'Length': 'Meters to Feet / Feet to Meters',
    'Weight': 'Kilograms to Pounds / Pounds to Kilograms',
  };

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0;
    double convertedValue;

    switch (_selectedConversion) {
      case 'Length':
        if (_result.isEmpty || _result.contains('Feet')) {
          convertedValue = input * 3.28084; // Meters to Feet
          setState(() {
            _result = '${input.toStringAsFixed(2)} Meters = ${convertedValue.toStringAsFixed(2)} Feet';
          });
        } else {
          convertedValue = input / 3.28084; // Feet to Meters
          setState(() {
            _result = '${input.toStringAsFixed(2)} Feet = ${convertedValue.toStringAsFixed(2)} Meters';
          });
        }
        break;
      case 'Weight':
        if (_result.isEmpty || _result.contains('Pounds')) {
          convertedValue = input * 2.20462; // Kilograms to Pounds
          setState(() {
            _result = '${input.toStringAsFixed(2)} Kilograms = ${convertedValue.toStringAsFixed(2)} Pounds';
          });
        } else {
          convertedValue = input / 2.20462; // Pounds to Kilograms
          setState(() {
            _result = '${input.toStringAsFixed(2)} Pounds = ${convertedValue.toStringAsFixed(2)} Kilograms';
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedConversion,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                  _result = '';
                });
              },
              items: conversionTypes.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
