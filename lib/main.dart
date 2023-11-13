import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the SplashScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> globalNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavKey,
      home: SplashScreen(), // Use the SplashScreen widget as the initial screen
    );
  }
}
