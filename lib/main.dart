import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'screens/opening_screen.dart';
import 'screens/home_screen.dart'; // ⬅️ Add this import

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      useInheritedMediaQuery: true,
      initialRoute: '/',
      routes: {
        '/': (context) => const OpeningScreen(),
        '/home': (context) => HomeScreen(), // ⬅️ Define the route
      },
    );
  }
}
