import 'package:flutter/material.dart';
import 'package:solo/splash_screen.dart';

void main() {
  runApp(const SoloApp());
}

class SoloApp extends StatelessWidget {
  const SoloApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blossom App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}