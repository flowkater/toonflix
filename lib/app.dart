import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        colorScheme: theme.colorScheme.copyWith(
          background: const Color(0xFFE64D3D),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
