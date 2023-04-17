import 'package:flutter/material.dart';
import 'package:leonardo_painter/home.dart';

void main() {
  runApp(
    const DaVinci(),
  );
}

class DaVinci extends StatelessWidget {
  const DaVinci({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade200, centerTitle: true),
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: Scaffold(),
    );
  }
}
