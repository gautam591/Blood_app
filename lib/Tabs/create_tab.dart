import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Manabata/requests.dart' as request;
import 'package:Manabata/alerts.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<CreatePage> {
  TextEditingController postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> user = {};

  TextEditingController urgencyLevelController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController addressAreaController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String selectedBloodGroup = 'A+';
  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  _EmergencyFormState(){
    setUserData();
  }

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    setState(() {
      user = json.decode(userRaw);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField2<String>(
                  isExpanded: false,
                  value: (urgencyLevelController.text).isEmpty? null : urgencyLevelController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You must choose your urgency level';
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
                    hintText: 'Urgency Level*',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'emergency', child: Text('Emergency')),
                    DropdownMenuItem(value: 'post', child: Text('Regular Post')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      urgencyLevelController.text = value ?? '';
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField2<String>(
                  isExpanded: false,
                  value: (bloodGroupController.text).isEmpty? null : bloodGroupController.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You must choose blood group';
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
                    hintText: 'Select Blood Group*',
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
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField("City*", addressCityController),
                const SizedBox(height: 16),
                _buildTextField("Area", addressAreaController, customValidator: (value) {return null;}),
                const SizedBox(height: 16),
                _buildTextField("Title", titleController, customValidator: (value) {return null;}),
                const SizedBox(height: 16),
                _buildTextField("Content", contentController, customValidator: (value) {return null;}),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    _formKey.currentState!.save();
                    if(_formKey.currentState!.validate()) {
                      final dateNow = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
                      final data = {
                        'username': '${user['uid']}',
                        'create_ts': dateNow,
                        'urgency_level': urgencyLevelController.text,
                        'blood_group': bloodGroupController.text,
                        'country': addressCountryController.text,
                        'state': addressStateController.text,
                        'city': addressCityController.text,
                        'area': addressAreaController.text,
                        'title': titleController.text,
                        'content': contentController.text,
                      };
                      Map<String, dynamic> response = await request.API.createPost(data);
                      if(response["status"] == true) {
                        Alerts.showSuccess("Successfully created a new post!");
                        // urgencyLevelController.clear();
                        // bloodGroupController.clear();
                        // addressCityController.clear();
                        // addressStateController.clear();
                        addressCityController.clear();
                        // addressAreaController.clear();
                        // titleController.clear();
                        // contentController.clear();
                      }
                      else{
                        Alerts.showError(response["messages"]["error"]);
                      }
                    }
                    if (kDebugMode) {
                      print("Create button pressed.");
                    }

                  },
                  child: const Text('Create Post'),
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


