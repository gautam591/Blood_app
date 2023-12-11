import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Manabata/home.dart';
import 'alerts.dart';
import 'login.dart';
import 'requests.dart' as request;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  Map<String, dynamic> user = {'uid': '#false#'};

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    if (userRaw != '') {
      setState(() {
        user = json.decode(userRaw);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUserData();
    WidgetsBinding.instance.addObserver(this); // Adding an observer
    Future.delayed(const Duration(seconds: 1), () async {
      if(user['uid'] != '#false#') {
        Alerts.showSuccess("You are logged in as: ${user['uid']}");
        await request.API.getAllData(user['uid']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else {
        Alerts.showGeneral("Please login or register to continue");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage(),
          ),
        );
      }

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
