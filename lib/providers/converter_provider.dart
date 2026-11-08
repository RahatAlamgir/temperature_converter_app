import 'package:flutter/material.dart';

import '../models/conversion_type.dart';

class ConverterProvider extends ChangeNotifier {
  final TextEditingController inputController = TextEditingController();

  ConversionType _conversionType = ConversionType.fahrenheitToCelsius;
  String? _errorText;
  String _result = '';

  ConversionType get conversionType => _conversionType;

  String? get errorText => _errorText;

  String get result => _result;

  void setConversionType(ConversionType type) {
    if (type == _conversionType) {
      return;
    }

    _conversionType = type;
    _result = '';
    _errorText = null;
    notifyListeners();
  }

  void calculate() {
    final String input = inputController.text.trim();

    if (input.isEmpty) {
      _fail('Please enter a temperature value');

      return;
    }

    final double? value = double.tryParse(input);

    if (value == null || !value.isFinite) {
      _fail('Please enter a valid number');

      return;
    }

    final double converted = _conversionType.convert(value);

    _errorText = null;
    _result = '${converted.toStringAsFixed(2)} ${_conversionType.resultUnit}';
    notifyListeners();
  }

  void _fail(String message) {
    _errorText = message;
    _result = '';
    notifyListeners();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
