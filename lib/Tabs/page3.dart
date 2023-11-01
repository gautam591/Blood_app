import 'package:flutter/material.dart';
import 'package:post_found/event_form.dart';
class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4.0, // Add elevation for the card shadow
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Post Title',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'This is the content of the post. It can be a long text describing the post in detail.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Add Photos:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement photo selection logic here
                        },
                        child: Text('Select Photos'),
                      ),
                      // Display selected photos here (if any)
                      // You can use Image widgets to show selected photos
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        // Add like functionality here
                      },
                    ),
                    Text('Like'),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Add comment functionality here
                      },
                    ),
                    Text('Comment'),
                    IconButton(
                      icon: Icon(Icons.mobile_screen_share),
                      onPressed: () {
                        // Add share functionality here
                      },
                    ),
                    Text('Share'),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 4.0, // Add elevation for the card shadow
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Post Title',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'This is the content of the post. It can be a long text describing the post in detail.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Add Photos:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement photo selection logic here
                        },
                        child: Text('Select Photos'),
                      ),
                      // Display selected photos here (if any)
                      // You can use Image widgets to show selected photos
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        // Add like functionality here
                      },
                    ),
                    Text('Like'),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Add comment functionality here
                      },
                    ),
                    Text('Comment'),
                    IconButton(
                      icon: Icon(Icons.mobile_screen_share),
                      onPressed: () {
                        // Add share functionality here
                      },
                    ),
                    Text('Share'),
                  ],
                ),
              ],
            ),
          ),
          AddButton(),
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
            Future.delayed(Duration(seconds: 0), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => EventForm(),
                ),
              );
            });
            // Add your logic to handle the addition of information
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red.shade500,
        ),
      ),
    );
  }
}

