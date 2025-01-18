import 'package:flutter/material.dart';

class ConversionPage extends StatefulWidget {
  final ValueChanged<MaterialColor> onThemeChanged;

  const ConversionPage({super.key, required this.onThemeChanged});

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  String _inputValue = '';
  double _conversionResult = 0.0;

  void _convert() {
    setState(() {
      // Example conversion logic (e.g., from meters to kilometers)
      _conversionResult = double.tryParse(_inputValue) ?? 0.0 / 1000;
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
            onPressed: () {
              widget.onThemeChanged(Colors.blue); // Example theme change
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Enter value'),
              onChanged: (value) {
                setState(() {
                  _inputValue = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            Text('Result: $_conversionResult'),
          ],
        ),
      ),
    );
  }
}
