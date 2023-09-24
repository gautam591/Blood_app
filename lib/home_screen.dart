import 'package:flutter/material.dart';
import 'page1.dart'; // Import the Page1 widget
import 'page2.dart'; // Import the Page2 widget
import 'page3.dart'; // Import the Page3 widget
import 'page4.dart'; // Import the Page4 widget
import 'editProfile.dart';


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
                color: Colors.blue,
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
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_rounded,color: Colors.black),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined,color: Colors.black),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined,color: Colors.black),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
      ),
    );
  }
}