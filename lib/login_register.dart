import 'package:flutter/material.dart';
import 'package:post_found/register.dart';
import 'package:post_found/home_screen.dart';


final FocusNode _emailFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();

class LoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: _emailFocus,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              focusNode: _passwordFocus,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ButtonTheme(
              minWidth: double.infinity, // Set a fixed button width
              height: 50.0, // Set a fixed button height
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  });
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();
                },
                child: Text('Sign-In'),
              ),
            ),
            SizedBox(height: 16.0),
            ButtonTheme(
              minWidth: double.infinity, // Set a fixed button width
              height: 50.0, // Set a fixed button height
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => RegisterPage(),
                      ),
                    );
                  });
                  // Implement registration logic here
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();
                },
                child: Text('Sign-Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





