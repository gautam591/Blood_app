import 'package:flutter/material.dart';
import 'Tabs/page1.dart'; // Import the Page1 widget
import 'Tabs/page2.dart'; // Import the Page2 widget
import 'Tabs/page3.dart'; // Import the Page3 widget
import 'Tabs/page4.dart'; // Import the Page4 widget
import 'editProfile.dart';
import 'package:flutter/src/material/colors.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text('Manabata'),
        actions: <Widget>[
          // Add a search icon at the right corner
          IconButton(
            icon: Icon(Icons.search),
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
              child: Text(
                'Samir Bhadel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to the home page or perform an action
                Future.delayed(Duration(seconds: 4), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterPage(),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: Text('My Rewards'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Account setting'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Report'),
              onTap: () {
                // Navigate to the profile page or perform an action
                Navigator.pop(context);
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.shade300,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_rounded,color: Colors.black),
            label: 'Emergency',
            backgroundColor: Colors.red.shade300,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined,color: Colors.black),
            label: 'Create Post',
            backgroundColor: Colors.red.shade300,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined,color: Colors.black),
            label: 'Events',
            backgroundColor: Colors.red.shade300,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active,color: Colors.black),
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