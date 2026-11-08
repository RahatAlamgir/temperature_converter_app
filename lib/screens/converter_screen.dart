import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conversion_type.dart';
import '../providers/converter_provider.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConverterProvider provider = context.watch<ConverterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(fontWeight: .bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: provider.inputController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),

                      decoration: InputDecoration(
                        labelText: 'Degrees',
                        errorText: provider.errorText,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ConversionType>(
                          value: provider.conversionType,
                          isExpanded: true,
                          isDense: true,

                          items: ConversionType.values
                              .map(
                                (ConversionType type) =>
                                    DropdownMenuItem<ConversionType>(
                                      value: type,
                                      child: Text(type.label),
                                    ),
                              )
                              .toList(),
                          onChanged: (ConversionType? type) {
                            if (type != null) {
                              provider.setConversionType(type);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Result',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                child: Text(provider.result.isEmpty ? ' ' : provider.result),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    provider.calculate();
                  },
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
