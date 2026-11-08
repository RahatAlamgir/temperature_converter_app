import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_converter_app/app.dart';
import 'package:temperature_converter_app/models/conversion_type.dart';

void main() {
  Future<void> calculate(WidgetTester tester, String input) async {
    await tester.enterText(find.byType(TextField), input);
    await tester.tap(find.text('Convert'));
    await tester.pump();
  }

  testWidgets('shows error when input is empty', (tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());
    await calculate(tester, '');

    expect(find.text('Please enter a temperature value'), findsOneWidget);
  });

  testWidgets('shows error when input is not a number', (tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());
    await calculate(tester, 'abc');

    expect(find.text('Please enter a valid number'), findsOneWidget);
  });

  testWidgets('converts Fahrenheit to Celsius by default', (tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());
    await calculate(tester, '72');

    expect(find.text('22.22 °C'), findsOneWidget);
  });

  testWidgets('converts Celsius to Fahrenheit', (tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());
    await tester.tap(find.byType(DropdownButton<ConversionType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(ConversionType.celsiusToFahrenheit.label).last);
    await tester.pumpAndSettle();
    await calculate(tester, '100');

    expect(find.text('212.00 °F'), findsOneWidget);
  });
}
