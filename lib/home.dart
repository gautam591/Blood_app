import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Tabs/page1.dart'; // Import the Page1 widget
import 'Tabs/page2.dart'; // Import the Page2 widget
import 'Tabs/page3.dart'; // Import the Page3 widget
import 'Tabs/page4.dart'; // Import the Page4 widget
import 'alerts.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'requests.dart' as request;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Map<String, dynamic> user = {'uid': 'Loading...'};
  bool dataFetched = false; // Add a flag to track if data has been fetched.

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // _HomePageState() {
  //   setUserData();
  // }
  @override
  void initState() {
    super.initState();
    setUserData();
    dataFetched = true;
  }

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    setState(() {
      user = json.decode(userRaw);
      dataFetched = true; // Set the flag to indicate data has been fetched.
    });
    if (kDebugMode) {
      print('Set User in Home: ${user['uid']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: const Text('Manabata'),
        actions: <Widget>[
          // Add a search icon at the right corner
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Create a navigation menu at the top left corner
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red.shade400,
              ),
              child: dataFetched ?
                Text(
                user['uid'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ) : const CircularProgressIndicator(),
            ),
            ListTile(
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to the home page or perform an action
                Future.delayed(const Duration(seconds: 0), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const EditProfilePage(),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('My Rewards'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Account Settings'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Report'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                Map<String, dynamic> response = await request.API.logout();
                if(response["status"] == true) {
                  Alerts.showWarning("You have been logged out!");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
                else{
                  Alerts.showError("There was a problem logging you out!");
                }
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.shade200,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.bloodtype_rounded,color: Colors.black),
            label: 'Emergency',
            backgroundColor: Colors.red.shade400,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.newspaper_outlined,color: Colors.black),
            label: 'Create Post',
            backgroundColor: Colors.red.shade300,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_available_outlined,color: Colors.black),
            label: 'Events',
            backgroundColor: Colors.red.shade300,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_active,color: Colors.black),
            label: 'Notification',
            backgroundColor: Colors.red.shade300,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
      ),
    );
  }
}