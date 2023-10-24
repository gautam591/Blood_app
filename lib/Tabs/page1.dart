import 'package:flutter/material.dart';
import 'package:post_found/EmergencyForm.dart';
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Postcard(
          profileName: 'User 1',
          date: 'October 24, 2023',
          postText: 'This is User 1\'s post content.',
        ),
        Postcard(
          profileName: 'User 2',
          date: 'October 25, 2023',
          postText: 'This is User 2\'s post content.',
        ),
        Postcard(
          profileName: 'User 3',
          date: 'October 26, 2023',
          postText: 'This is User 3\'s post content.',
        ),
        AddButton(),
        // Add more Postcard widgets for additional users
      ],
    );
  }
}

class Postcard extends StatelessWidget {
  final String profileName;
  final String date;
  final String postText;

  Postcard({
    required this.profileName,
    required this.date,
    required this.postText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              // Insert profile picture here
            ),
            title: Text(profileName),
            subtitle: Text(date),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(postText),
          ),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Handle like action
                },
                icon: Icon(Icons.thumb_up),
                label: Text('Like'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Handle comment action
                },
                icon: Icon(Icons.comment),
                label: Text('Comment'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Handle share action
                },
                icon: Icon(Icons.screen_share_rounded),
                label: Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => EmergencyForm(),
                ),
              );
            });
            // Add your logic to handle the addition of information
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}
