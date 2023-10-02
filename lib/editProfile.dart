import 'package:flutter/material.dart';
import 'home_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Define controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressAreaController = TextEditingController();

  int currentStep = 0;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
        // Add a back arrow button in the app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            }
            if (currentStep == 0) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
                  ),
                );
              });
            }
           // Navigate back to the previous screen/page
          },
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep < 4) {
            setState(() {
              currentStep++;
            });
          } else {
            // Handle registration logic here
            print("Registration complete.");
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
          if (currentStep == 0) {
            Navigator.pop(context);
          }
        },
        steps: [
          Step(
            title: Text('Account Information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField("Email", emailController),
                SizedBox(height: 10),
                _buildTextField("Password", passwordController),
                SizedBox(height: 10),
                _buildTextField("Confirm Password", confirmPasswordController),

              ],
            ),
            isActive: currentStep == 0,
          ),
          Step(
            title: Text('Personal Information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField("Name", nameController),
                SizedBox(height: 10),
                _buildTextField("Phone Number", phoneNumberController),
                SizedBox(height: 10),
                _buildTextField("Email address", emailController),

              ],
            ),
            isActive: currentStep == 1,
          ),
          Step(
            title: Text('Blood Group'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                _buildTextField("Blood group (e.g. O-, AB-, O+)", bloodGroupController),
              ],
            ),
            isActive: currentStep == 2,
          ),

          Step(
            title: Text('Address info'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField("Country", addressCountryController),
                SizedBox(height: 10),
                _buildTextField("State", addressStateController),
                SizedBox(height: 10),
                _buildTextField("city", addressCityController),
                SizedBox(height: 10),
                _buildTextField("Area", addressAreaController),

              ],
            ),
            isActive: currentStep == 3,
          ),
          Step(
            title: Text('Confirmation'),
            content: Column(
              children: [
                Text("Review and confirm your information."),
              ],
            ),
            isActive: currentStep == 4,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
