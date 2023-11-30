import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_found/home.dart';
import 'alerts.dart';
import 'login.dart'; // Import the HomeScreen widget
import 'requests.dart' as request;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  Map<String, dynamic> user = {'uid': '#false#'};
  Timer? timer;
  bool waitingForResponse = false;

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
    // Simulate a loading delay (e.g., loading data from a server)
    Future.delayed(const Duration(seconds: 1), () async {
      if(user['uid'] != '#false#') {
        Alerts.showSuccess("You are logged in as: ${user['uid']}");
        await request.API.getAllData(user['uid']);
        setTimer(false);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setTimer(state != AppLifecycleState.resumed);
  }

  void setTimer(bool isBackground) {
    int delaySeconds = isBackground ? 60 : 30;
    // Cancelling previous timer, if there was one, and creating a new one
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: delaySeconds), (t) async {
      // Not sending a request, if waiting for response
      if (!waitingForResponse) {
        waitingForResponse = true;
        if (kDebugMode) {
          print("Periodic request made");
        }
        await request.API.getAlerts(user['uid']);
        if (kDebugMode) {
          print("Periodic request complete");
        }
        waitingForResponse = false;
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
