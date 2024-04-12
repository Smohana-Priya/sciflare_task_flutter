// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../service/api_service.dart';
import '../widgets/common_textfield.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  String _name = '';
  String _email = '';
  String _mobile = '';
  String _selectedGender = '';
  String? _genderError;
  void _createAccount() async {
    try {
      var apiService = ApiService();
      var response = await apiService.createUser(
        name: _name,
        email: _email,
        mobile: _mobile,
        gender: _selectedGender,
      );

      print('User created: $response');
    } catch (error) {
      print('Error creating user: $error');
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(
                    label: 'Name',
                    hintText: "Enter Name",
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    label: 'Email',
                    hintText: "Enter Email Address",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    label: 'Mobile',
                    hintText: "Enter Mobile Number",
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _mobile = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (value.length != 10 ||
                          int.tryParse(value) == null) {
                        return 'Please enter a valid 10-digit mobile number';
                      } else if (value.length > 10) {
                        return 'Mobile number should not exceed 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Gender',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showGenderPicker(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: _genderError != null
                                    ? Theme.of(context).errorColor
                                    : Colors.grey,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      _showGenderPicker(context);
                                    },
                                    decoration: InputDecoration(
                                      hintText: _selectedGender.isNotEmpty
                                          ? _selectedGender
                                          : "Select Gender",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _genderError != null
                          ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    _genderError != null ? _genderError! : '',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                        fontSize: 13),
                                  )))
                          : Container()
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedGender.isNotEmpty) {
                            _createAccount();
                          } else if (_selectedGender.isEmpty) {
                            setState(() {
                              _genderError = 'Please select your gender';
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                          // shape: MaterialStateProperty.all<OutlinedBorder>(
                          //   RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          // ),
                        ),
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showGenderPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Male'),
                  onTap: () {
                    _selectGender('Male');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Female'),
                  onTap: () {
                    _selectGender('Female');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Other'),
                  onTap: () {
                    _selectGender('Other');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
      _genderError = null;
    });
  }
}
