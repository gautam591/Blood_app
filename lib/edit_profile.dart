import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'requests.dart' as request;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  // Define controllers for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressAreaController = TextEditingController();

  Map<String, dynamic> user = {};

  int currentStep = 0;
  bool complete = false;
  String? selectedBloodGroup;

  _EditProfilePageState() {
    setUserData();
  }

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    user = json.decode(userRaw);
    usernameController.text = user['uid'];
    emailController.text = user['email'];
    phoneNumberController.text = user['phone_number'];
    // bloodGroupController.text = ;
    // addressCountryController.text = ;
    // addressStateController.text = ;
    // addressCityController.text = ;
    //  addressAreaController.text = ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: const Text('Edit Your Profile'),
        // Add a back arrow button in the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            }
            if (currentStep == 0) {
              Future.delayed(const Duration(seconds: 0), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                );
              });
            }
           // Navigate back to the previous screen/page
          },
        ),
      ),
      body: Theme(
        data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.redAccent,
              // secondary: Colors.green,
            )
        ),
        child: Stepper(
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < 4) {
              _formKey.currentState!.save();
              if(_formKey.currentState!.validate()) {
                setState(() {
                  currentStep++;
                });
              }
            } else {
              // Handle registration logic here
              if (kDebugMode) {
                print("Registration complete.");
              }
              Future.delayed(const Duration(seconds: 0), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
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
          },

          steps: [
            Step(
              title: const Text('Account Information'),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    _buildTextField("Username*", usernameController),
                    const SizedBox(height: 15),
                    _buildTextField("Email Address*", emailController),
                  ],
                ),
              ),
              isActive: currentStep == 0,
            ),
            Step(
              title: const Text('Personal Information'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  _buildTextField("First Name", firstNameController),
                  const SizedBox(height: 15),
                  _buildTextField("Last Name", lastNameController),
                  const SizedBox(height: 15),
                  _buildTextField("Phone Number*", phoneNumberController),
                ],
              ),
              isActive: currentStep == 1,
            ),
            Step(
              title: const Text('Blood Group Information'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField2<String>(
                    isExpanded: false,
                    value: selectedBloodGroup,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          width: 0.5, // Border width
                        ),
                      ),
                      // filled: true,
                      // fillColor: Colors.grey[200],
                      hintText: 'Select your Blood Group*',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'A+', child: Text('A+ (A Positive)')),
                      DropdownMenuItem(value: 'A-', child: Text('A- (A Negative)')),
                      DropdownMenuItem(value: 'B+', child: Text('B+ (B Positive)')),
                      DropdownMenuItem(value: 'B-', child: Text('B- (B Negative)')),
                      DropdownMenuItem(value: 'O+', child: Text('O+ (O Positive)')),
                      DropdownMenuItem(value: 'O-', child: Text('O- (O Negative)')),
                      DropdownMenuItem(value: 'AB+', child: Text('AB+ (AB Positive)')),
                      DropdownMenuItem(value: 'AB-', child: Text('AB- (AB Negative)')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroup = value;
                      });
                    },
                  )
                ],
              ),
              isActive: currentStep == 2,
            ),

            Step(
              title: const Text('Address Information'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  _buildTextField("Country*", addressCountryController),
                  const SizedBox(height: 15),
                  _buildTextField("State*", addressStateController),
                  const SizedBox(height: 15),
                  _buildTextField("City*", addressCityController),
                  const SizedBox(height: 15),
                  _buildTextField("Area", addressAreaController),

                ],
              ),
              isActive: currentStep == 3,
            ),
            Step(
              title: const Text('Confirmation'),
              content: const Column(
                children: [
                  SizedBox(height: 5),
                  Text("Review and confirm your information."),
                ],
              ),
              isActive: currentStep == 4,
            ),
          ],
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
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          // borderSide: BorderSide(color: Colors.black),
        ),
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
