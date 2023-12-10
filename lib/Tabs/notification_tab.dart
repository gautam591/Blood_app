import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Manabata/requests.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab>{
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> user = {};
  Map<String, dynamic> dataNotifications = {};
  List<String> notifications = [];


  Future<void> getNotifications({bool refresh = true}) async {
    String alertsRaw = json.encode(await API.getAlerts(user['uid'], refresh: refresh));
    dataNotifications = json.decode(alertsRaw)['data'];
    setState(() {
      notifications = [];
      dataNotifications.forEach((key, value) {
        notifications.add('$value');
      });
    });
  }

  Future<void> setUserData() async {
    String userRaw = await getLocalData('user') as String;
    String userDetailsRaw = await getLocalData('user_details') as String;
    setState(() {
      user = json.decode(userRaw);
      userDetails = json.decode(userDetailsRaw);
    });

  }

  @override
  void initState() {
    super.initState();
    setUserData();
    Future.delayed(const Duration(seconds: 0), () {
      getNotifications(refresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getNotifications,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            double topPadding = index == 0 ? 20.0 : 10.0;
            return Container(
              margin: EdgeInsets.only(top: topPadding),
              child: ListTile(
                title: Text(notifications[index]),
                leading: const Icon(Icons.notifications,color: Colors.redAccent,),
              ),
            );
          },
        ),
      ),
    );
  }
}
