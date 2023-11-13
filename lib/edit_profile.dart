import 'dart:convert';
import 'package:flutter/material.dart';
import 'alerts.dart';
import 'home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'requests.dart' as request;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKeyAccountInformation = GlobalKey<FormState>();
  final _formKeyPersonalInformation = GlobalKey<FormState>();
  final _formKeyBloodGroupInformation = GlobalKey<FormState>();
  final _formKeyAddressInformation = GlobalKey<FormState>();
  Map<int, GlobalKey<FormState>> formKeys= {};

  // Define controllers for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressAreaController = TextEditingController();

  List<DropdownMenuItem<String>> cityDropdownItems = [];

  Map<String, dynamic> user = {};
  Map<String, dynamic> userDetails = {};

  int currentStep = 0;
  bool complete = false;

  _EditProfilePageState() {
    setUserData();
  }

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    String userDetailsRaw = await request.getLocalData('user_details') as String;
    user = json.decode(userRaw);
    userDetails = json.decode(userDetailsRaw);

    usernameController.text = user['uid'];
    emailController.text = user['email'];
    phoneNumberController.text = user['phone_number'] ?? '';
    firstNameController.text = userDetails['first_name'] ?? '';
    lastNameController.text = userDetails['last_name'] ?? '';
    bloodGroupController.text = userDetails['blood_group_name'] ?? '';
    addressCountryController.text = userDetails['country'] ?? '';
    addressStateController.text = userDetails['state'] ?? '';
    addressCityController.text = userDetails['city'] ?? '';
    addressAreaController.text = userDetails['area'] ?? '';

    buildCityDropdown(addressStateController.text);
  }

  Future<void> buildCityDropdown(String state) async {
    if(state != null && state.isNotEmpty && state!= '') {

    }
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
          onStepContinue: () async {
            formKeys = {
              0: _formKeyAccountInformation,
              1: _formKeyPersonalInformation,
              2: _formKeyBloodGroupInformation,
              3: _formKeyAddressInformation,
            };
            if (currentStep < 4) {
              formKeys[currentStep]!.currentState!.save();
              if(formKeys[currentStep]!.currentState!.validate()) {
                setState(() {
                  currentStep++;
                });
              }
            } else {
                final data = {
                  'username': usernameController.text,
                  'email': emailController.text,
                  'phone_number': phoneNumberController.text,
                  'first_name': firstNameController.text,
                  'last_name': lastNameController.text,
                  'blood_group_name': bloodGroupController.text,
                  'country': addressCountryController.text,
                  'state': addressStateController.text,
                  'city': addressCityController.text,
                  'area': addressAreaController.text,
                };
                Map<String, dynamic> response = await request.API.update(data);
                if(response["status"] == true) {
                  Alerts.showSuccess(response["messages"]["success"]);
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
                key: _formKeyAccountInformation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    _buildTextField("Username* (cannot be changed)", usernameController, customReadOnly: true),
                    const SizedBox(height: 15),
                    _buildTextField("Email Address*", emailController, customKeyboardType: TextInputType.emailAddress),
                  ],
                ),
              ),
              isActive: currentStep == 0,
            ),
            Step(
              title: const Text('Personal Information'),
              content: Form(
                key: _formKeyPersonalInformation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    _buildTextField("First Name", firstNameController, customKeyboardType: TextInputType.text, customValidator: (value) {return null;}),
                    const SizedBox(height: 15),
                    _buildTextField("Last Name", lastNameController, customKeyboardType: TextInputType.text, customValidator: (value) {return null;}),
                    const SizedBox(height: 15),
                    _buildTextField("Phone Number*", phoneNumberController, customValidator: (value) {
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
                  ],
                ),
              ),
              isActive: currentStep == 1,
            ),
            Step(
              title: const Text('Blood Group Information'),
              content: Form(
                key: _formKeyBloodGroupInformation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField2<String>(
                      isExpanded: false,
                      value: (bloodGroupController.text).isEmpty? null : bloodGroupController.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must choose your blood group';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            // width: 0.5, // Border width
                          ),
                        ),
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
                          bloodGroupController.text = value ?? '';
                        });
                      },
                    )
                  ],
                ),
              ),
              isActive: currentStep == 2,
            ),

            Step(
              title: const Text('Address Information'),
              content: Form(
                key: _formKeyAddressInformation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    DropdownButtonFormField2<String>(
                      isExpanded: false,
                      value: (addressCountryController.text).isEmpty? null : addressCountryController.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must choose your country';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            // width: 0.5, // Border width
                          ),
                        ),
                        hintText: 'Country*',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Nepal', child: Text('Nepal')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          addressCountryController.text = value ?? '';
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField2<String>(
                      isExpanded: false,
                      value: (addressStateController.text).isEmpty? null : addressStateController.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must choose your state';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            // width: 0.5, // Border width
                          ),
                        ),
                        hintText: 'State*',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Bagmati Province', child: Text('Bagmati Province')),
                        DropdownMenuItem(value: 'Gandaki Province', child: Text('Gandaki Province')),
                        DropdownMenuItem(value: 'Karnali Province', child: Text('Karnali Province')),
                        DropdownMenuItem(value: 'Koshi Province', child: Text('Koshi Province')),
                        DropdownMenuItem(value: 'Lumbini Province', child: Text('Lumbini Province')),
                        DropdownMenuItem(value: 'Madhesh Province', child: Text('Madhesh Province')),
                        DropdownMenuItem(value: 'Sudur Paschimanchal Province', child: Text('Sudur Paschimanchal Province')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          addressStateController.text = value ?? '';
                          buildCityDropdown(addressStateController.text);
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField("City*", addressCityController),
                    const SizedBox(height: 15),
                    _buildTextField("Area", addressAreaController, customValidator: (value) {return null;}),

                  ],
                ),
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
        TextInputType? customKeyboardType,
        bool? customObscureText,
        String? Function(dynamic)? customValidator,
        bool? customReadOnly,
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
      keyboardType: customKeyboardType ?? TextInputType.text,
      obscureText: customObscureText ?? false,
      readOnly:  customReadOnly ?? false,
      validator: customValidator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
