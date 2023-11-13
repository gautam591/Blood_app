import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'requests.dart' as request;
import 'alerts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  // Define controllers for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.red.shade400,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );// Navigate back to the previous screen/page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField("Username *", usernameController, customkeyboardType: TextInputType.text),
                const SizedBox(height: 16),
                _buildTextField("Email Address *", emailController, customkeyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildTextField("Phone Number", phoneNumberController, customkeyboardType: TextInputType.phone,
                    customValidator: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number (+9771234567890)';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                _buildTextField("Password *", passwordController, customkeyboardType: TextInputType.visiblePassword, customObscureText: true, customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (value .length < 6) {
                    return 'Minimum length of password is 6';
                  }
                  if (value != confirmPasswordController.text) {
                    return 'Passwords are not same';
                  }
                  return null; // Return null if the input is valid
                },),
                const SizedBox(height: 16),
                _buildTextField("Confirm Password *", confirmPasswordController, customkeyboardType: TextInputType.visiblePassword, customObscureText: true, customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (value .length < 6) {
                    return 'Minimum length of password is 6';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords are not same';
                  }
                  return null;
                }),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    _formKey.currentState!.save();
                    if(_formKey.currentState!.validate()) {
                      final data = {
                        'username': usernameController.text,
                        'display_name': usernameController.text,
                        'email': emailController.text,
                        'phone_number': phoneNumberController.text,
                        'password': passwordController.text,
                      };
                      Map<String, dynamic> response = await request.API.register(data);
                      if(response["status"] == true) {
                        // print("Response under true: $response");
                        // Alerts.showSuccess(response["messages"]["success"]);
                        Alerts.showSuccess("Successfully registered!. Please proceed to login with the user (${usernameController.text}) you just registered with!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      }
                      else{
                        Alerts.showError(response["messages"]["error"]);
                      }
                    }
                    if (kDebugMode) {
                      print("Registration button pressed.");
                    }

                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      {
        TextInputType? customkeyboardType,
        bool? customObscureText,
        String? Function(dynamic)? customValidator,
      }
    ){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: label,
      ),
      keyboardType: customkeyboardType ?? TextInputType.text,
      obscureText: customObscureText ?? false,
      validator: customValidator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
