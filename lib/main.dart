import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'NotificationService.dart';
import 'splash_screen.dart';
import 'requests.dart' as request;
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Map<String, dynamic> user = {'uid': '#true#'};
Timer? timer;
bool waitingForResponse = false;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String userRaw = await request.getLocalData('user') as String;
  if (userRaw != '') {
    user = json.decode(userRaw);
  }
  await Permission.notification.request();
  NotificationService().initNotification();
  await initializeService();
  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  int delaySeconds =  10;

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: delaySeconds), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        // service.setForegroundNotificationInfo(
        //   title: "My App Service",
        //   content: "Updated at ${DateTime.now()}",
        // );
        if (!waitingForResponse) {
          waitingForResponse = true;
          if (kDebugMode) {
            print("Periodic request made as User: ${user['uid']}");
          }
          await request.API.getAlerts(user['uid']);
          if (kDebugMode) {
            print("Periodic request complete");
          }
          waitingForResponse = false;
        }
      }
    }
  });
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> globalNavKey = GlobalKey();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavKey,
      home: const SplashScreen(), // Use the SplashScreen widget as the initial screen
    );
  }
}
