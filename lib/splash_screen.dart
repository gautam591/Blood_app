import 'package:flutter/material.dart';
import 'package:post_found/home.dart';
import 'login.dart'; // Import the HomeScreen widget

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay (e.g., loading data from a server)
    Future.delayed(const Duration(seconds: 0), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Image.asset(
            'assets/logo.png',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          // Centered Loading Indicator
          const Center(
            child: CircularProgressIndicator(color:Colors.black),
          ),
        ],
      ),
    );
  }
}
