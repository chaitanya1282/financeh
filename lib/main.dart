import 'package:flutter/material.dart';
import 'screen/login_screen.dart'; // Import all screen files
import 'screen/home_screen.dart';
import 'screen/market_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/market': (context) => MarketScreen(), // Added MarketScreen route
      },
    );
  }
}