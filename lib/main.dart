import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'unit_conversion_app.dart';


void main() {
  runApp(const UnitConversionApp());
}

class ThemeChanger extends StatelessWidget {
  final ValueChanged<Color> onColorChanged;

  const ThemeChanger({super.key, required this.onColorChanged});

  void _showColorPicker(BuildContext context) {
    Color pickerColor = Colors.blue; // Default initial color

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color; // Update selected color
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onColorChanged(pickerColor); // Pass selected color back
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.color_lens),
      onPressed: () => _showColorPicker(context),
    );
  }
}
