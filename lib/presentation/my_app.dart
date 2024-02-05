import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
    );
  }
}
