import 'package:flutter/material.dart';

class ThemeEditor extends StatelessWidget {
  final ValueChanged<MaterialColor> onThemeChanged;

  const ThemeEditor({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Theme Color'),
      content: SingleChildScrollView(
        child: Column(
          children: Colors.primaries.map((color) {
            return GestureDetector(
              onTap: () {
                onThemeChanged(color);
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
  }
}
