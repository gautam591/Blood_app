import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';
import 'requests.dart' as request;
import 'alerts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.red.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Form(
          key: _formKey,
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: _emailFocus,
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username or Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Username or Email';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                focusNode: _passwordFocus,
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (value .length < 6) {
                    return 'Minimum length of password is 6';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 16.0),
              ButtonTheme(
                minWidth: double.infinity, // Set a fixed button width
                height: 50.0, // Set a fixed button height
                child: ElevatedButton(
                  onPressed: () async {
                    _emailFocus.unfocus();
                    _passwordFocus.unfocus();
                    _formKey.currentState!.save();
                    if(_formKey.currentState!.validate()){
                      final data = {
                        'username': usernameController.text,
                        'password': passwordController.text,
                      };
                      Map<String, dynamic> response = await request.API.login(data);
                      if(response["status"] == true) {
                        Alerts.showSuccess(response["messages"]["success"]);
                        await request.API.getAllData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                      else{
                        Alerts.showError(response["messages"]["error"]);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
                  child: const Text('Sign-In'),
                ),
              ),
              const SizedBox(height: 16.0),
              ButtonTheme(
                minWidth: double.infinity, // Set a fixed button width
                height: 50.0, // Set a fixed button height
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()), // Navigate to RegisterPage
                    );
                    _emailFocus.unfocus();
                    _passwordFocus.unfocus();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
                  child: const Text('Sign-Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





