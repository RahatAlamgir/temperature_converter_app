import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/converter_provider.dart';
import 'screens/converter_screen.dart';

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConverterProvider>(
      create: (_) => ConverterProvider(),
      child: MaterialApp(
        title: 'Temperature Converter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const ConverterScreen(),
      ),
    );
  }
}
