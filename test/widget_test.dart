import 'package:anyunit/unit_conversion_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Unit conversion input test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UnitConversionApp());

    // Verify that the initial input field is empty.
    expect(find.text(''), findsOneWidget);

    // Enter a value into the input field.
    await tester.enterText(find.byType(TextField), '100');
    await tester.pump();

    // Verify that the input field contains the entered value.
    expect(find.text('100'), findsOneWidget);
  });
}
