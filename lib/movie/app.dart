import 'package:flutter/material.dart';
import 'package:toonflix/movie/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
          background: Colors.white,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
