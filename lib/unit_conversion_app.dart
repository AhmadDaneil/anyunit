import 'package:flutter/material.dart';
import 'calculator_widget.dart';

class UnitConversionApp extends StatefulWidget {
  const UnitConversionApp({super.key});

  @override
  _UnitConversionAppState createState() => _UnitConversionAppState();
}

class _UnitConversionAppState extends State<UnitConversionApp> {
  MaterialColor _themeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: _themeColor,
        scaffoldBackgroundColor: _themeColor.shade100,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: _themeColor.shade900),
          bodyMedium: TextStyle(color: _themeColor.shade900),
        ),
      ),
      home: ConversionPage(
        onThemeChanged: (color) {
          setState(() {
            _themeColor = color;
          });
        },
      ),
    );
  }
}

class ConversionPage extends StatefulWidget {
  final ValueChanged<MaterialColor> onThemeChanged;

  const ConversionPage({super.key, required this.onThemeChanged});

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final List<Map<String, dynamic>> _conversions = [
    {'input': TextEditingController(), 'unitFrom': 'Meters', 'unitTo': 'Feet', 'result': ''}
  ];

  final Map<String, List<String>> unitCategories = {
    'Length': ['Meters', 'Feet', 'Kilometers', 'Miles', 'Yards', 'Inches'],
    'Weight': ['Kilograms', 'Pounds', 'Grams', 'Ounces', 'Micrograms', 'Milligrams'],
    'Volume': ['Liters', 'Gallons', 'Milliliters', 'Cups', 'Cubic Meters', 'Cubic Feet'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Speed': ['Meters/Second', 'Kilometers/Hour', 'Miles/Hour', 'Kilometers/Second', 'Feet/Hour'],
  };

  String _selectedCategory = 'Length';
  bool _showCalculator = false;

  void _convertAll() {
    for (var conversion in _conversions) {
      double input = double.tryParse(conversion['input'].text) ?? 0;
      double result = _performConversion(input, conversion['unitFrom'], conversion['unitTo']);

      setState(() {
        conversion['result'] =
            '${input.toStringAsFixed(2)} ${conversion['unitFrom']} = ${result.toStringAsFixed(2)} ${conversion['unitTo']}';
      });
    }
  }

  double _performConversion(double input, String unitFrom, String unitTo) {
    if (_selectedCategory == 'Length') {
      if (unitFrom == 'Meters' && unitTo == 'Feet') return input * 3.28084;
      if (unitFrom == 'Feet' && unitTo == 'Meters') return input / 3.28084;
      if (unitFrom == 'Kilometers' && unitTo == 'Miles') return input * 0.621371;
      if (unitFrom == 'Miles' && unitTo == 'Kilometers') return input / 0.621371;
      if (unitFrom == 'Yards' && unitTo == 'Inches') return input * 36;
      if (unitFrom == 'Inches' && unitTo == 'Yards') return input / 36;
    } else if (_selectedCategory == 'Weight') {
      if (unitFrom == 'Kilograms' && unitTo == 'Pounds') return input * 2.20462;
      if (unitFrom == 'Pounds' && unitTo == 'Kilograms') return input / 2.20462;
      if (unitFrom == 'Micrograms' && unitTo == 'Milligrams') return input / 1000;
      if (unitFrom == 'Milligrams' && unitTo == 'Micrograms') return input * 1000;
    } else if (_selectedCategory == 'Volume') {
      if (unitFrom == 'Liters' && unitTo == 'Gallons') return input * 0.264172;
      if (unitFrom == 'Gallons' && unitTo == 'Liters') return input / 0.264172;
      if (unitFrom == 'Cubic Meters' && unitTo == 'Cubic Feet') return input * 35.3147;
      if (unitFrom == 'Cubic Feet' && unitTo == 'Cubic Meters') return input / 35.3147;
    } else if (_selectedCategory == 'Temperature') {
      if (unitFrom == 'Celsius' && unitTo == 'Fahrenheit') return input * 9 / 5 + 32;
      if (unitFrom == 'Fahrenheit' && unitTo == 'Celsius') return (input - 32) * 5 / 9;
      if (unitFrom == 'Celsius' && unitTo == 'Kelvin') return input + 273.15;
      if (unitFrom == 'Kelvin' && unitTo == 'Celsius') return input - 273.15;
    } else if (_selectedCategory == 'Speed') {
      if (unitFrom == 'Meters/Second' && unitTo == 'Kilometers/Second') return input / 1000;
      if (unitFrom == 'Kilometers/Second' && unitTo == 'Meters/Second') return input * 1000;
      if (unitFrom == 'Feet/Hour' && unitTo == 'Meters/Second') return input * 0.000084667;
      if (unitFrom == 'Meters/Second' && unitTo == 'Feet/Hour') return input / 0.000084667;
    }
    return input;
  }

  void _addConversionField() {
    setState(() {
      _conversions.add({
        'input': TextEditingController(),
        'unitFrom': unitCategories[_selectedCategory]![0],
        'unitTo': unitCategories[_selectedCategory]![1],
        'result': ''
      });
    });
  }

  void _removeConversionField(int index) {
    setState(() {
      _conversions.removeAt(index);
    });
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Theme Color'),
          content: SingleChildScrollView(
            child: Column(
              children: Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () {
                    widget.onThemeChanged(color);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: color,
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _toggleCalculator() {
    setState(() {
      _showCalculator = !_showCalculator;
    });
  }

  void _resetConversions() {
    setState(() {
      for (var conversion in _conversions) {
        conversion['input'].clear();
        conversion['result'] = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: _showThemeDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                'Category: $_selectedCategory',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              children: unitCategories.keys.map((category) {
                return ListTile(
                  title: Text(category),
                  tileColor: category == _selectedCategory
                      ? Theme.of(context).primaryColorLight
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                      for (var conversion in _conversions) {
                        conversion['unitFrom'] = unitCategories[category]![0];
                        conversion['unitTo'] = unitCategories[category]![1];
                        conversion['result'] = '';
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _toggleCalculator,
              child: Text(_showCalculator ? 'Hide Calculator' : 'Show Calculator'),
            ),
            if (_showCalculator) const CalculatorWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: _conversions.length,
                itemBuilder: (context, index) {
                  final conversion = _conversions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: conversion['input'],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter value',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeConversionField(index),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  value: conversion['unitFrom'],
                                  onChanged: (newValue) {
                                    setState(() {
                                      conversion['unitFrom'] = newValue!;
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
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward),
                              const SizedBox(width: 8),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: conversion['unitTo'],
                                  onChanged: (newValue) {
                                    setState(() {
                                      conversion['unitTo'] = newValue!;
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
                              ),
                            ],
                          ),
                          Text(
                            conversion['result'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addConversionField,
              child: const Text('Add Conversion'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _convertAll,
              child: const Text('Convert All'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetConversions,
              child: const Text('Reset All'),
            ),
          ],
        ),
      ),
    );
  }
}