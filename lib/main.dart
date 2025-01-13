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
  String _selectedCategory = 'Length';
  String _selectedUnitFrom = 'Meters';
  String _selectedUnitTo = 'Feet';
  String _result = '';

  final Map<String, List<String>> unitCategories = {
    'Length': ['Meters', 'Feet', 'Kilometers', 'Miles'],
    'Weight': ['Kilograms', 'Pounds', 'Grams', 'Ounces'],
    'Volume': ['Liters', 'Gallons', 'Milliliters', 'Cups'],
  };

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0;
    double convertedValue = 0;

    if (_selectedCategory == 'Length') {
      if (_selectedUnitFrom == 'Meters' && _selectedUnitTo == 'Feet') {
        convertedValue = input * 3.28084;
      } else if (_selectedUnitFrom == 'Feet' && _selectedUnitTo == 'Meters') {
        convertedValue = input / 3.28084;
      } else if (_selectedUnitFrom == 'Kilometers' && _selectedUnitTo == 'Miles') {
        convertedValue = input * 0.621371;
      } else if (_selectedUnitFrom == 'Miles' && _selectedUnitTo == 'Kilometers') {
        convertedValue = input / 0.621371;
      } else {
        convertedValue = input; // Same units, no conversion
      }
    } else if (_selectedCategory == 'Weight') {
      if (_selectedUnitFrom == 'Kilograms' && _selectedUnitTo == 'Pounds') {
        convertedValue = input * 2.20462;
      } else if (_selectedUnitFrom == 'Pounds' && _selectedUnitTo == 'Kilograms') {
        convertedValue = input / 2.20462;
      } else if (_selectedUnitFrom == 'Grams' && _selectedUnitTo == 'Ounces') {
        convertedValue = input * 0.035274;
      } else if (_selectedUnitFrom == 'Ounces' && _selectedUnitTo == 'Grams') {
        convertedValue = input / 0.035274;
      } else {
        convertedValue = input;
      }
    } else if (_selectedCategory == 'Volume') {
      if (_selectedUnitFrom == 'Liters' && _selectedUnitTo == 'Gallons') {
        convertedValue = input * 0.264172;
      } else if (_selectedUnitFrom == 'Gallons' && _selectedUnitTo == 'Liters') {
        convertedValue = input / 0.264172;
      } else if (_selectedUnitFrom == 'Milliliters' && _selectedUnitTo == 'Cups') {
        convertedValue = input * 0.00422675;
      } else if (_selectedUnitFrom == 'Cups' && _selectedUnitTo == 'Milliliters') {
        convertedValue = input / 0.00422675;
      } else {
        convertedValue = input;
      }
    }

    setState(() {
      _result = '${input.toStringAsFixed(2)} $_selectedUnitFrom = ${convertedValue.toStringAsFixed(2)} $_selectedUnitTo';
    });
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
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _selectedUnitFrom = unitCategories[_selectedCategory]![0];
                  _selectedUnitTo = unitCategories[_selectedCategory]![1];
                  _result = '';
                });
              },
              items: unitCategories.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedUnitFrom,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnitFrom = newValue!;
                });
              },
              items: unitCategories[_selectedCategory]!
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _selectedUnitTo,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnitTo = newValue!;
                });
              },
              items: unitCategories[_selectedCategory]!
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
