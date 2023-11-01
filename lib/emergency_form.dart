import 'package:flutter/material.dart';
import 'package:post_found/Tabs/page1.dart';
import 'package:post_found/home.dart';

class EmergencyForm extends StatefulWidget {
  @override
  _emergencyFormState createState() => _emergencyFormState();
}

class _emergencyFormState extends State<EmergencyForm> {
  TextEditingController postController = TextEditingController();
  String selectedBloodGroup = 'A+';
  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            });// Navigate back to the previous screen/page
          },
        ),
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select Blood Group: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedBloodGroup,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedBloodGroup = newValue;
                        });
                      }
                    },
                    items: bloodGroups.map((String bloodGroup) {
                      return DropdownMenuItem<String>(
                        value: bloodGroup,
                        child: Text(bloodGroup),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                // Handle description input
              },
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
              onPressed: () {
                // Handle the post button action here
                // You can access the selected blood group using 'selectedBloodGroup'
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}


