import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:rtc_app/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatelessWidget {
  final void Function()? onTap;

  Register({super.key, required this.onTap});

  final TextEditingController usrnameCo = TextEditingController();
  final TextEditingController emailCo = TextEditingController();
  final TextEditingController passCo = TextEditingController();
  final TextEditingController confirmCo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Proceed with registration if the form is valid
       // Gather user information
    String username = usrnameCo.text;
    String email = emailCo.text;
    String password = passCo.text;
    Map<String, dynamic> userData = {
      'name': username,
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      print(response.body);
      if (response.statusCode == 201) {
        print('User registered successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(onTap: onTap)),
        );
      } else {
        print('Failed to register user');
      }
    } catch (error) {
      print('Error registering user: $error');
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          width: 400,
                          height: 300,
                          child: Image.asset("assets/h2.jpg"),
                        ),
                      ),
                      SizedBox(height: 10,),
                      CoTextfield(
                        controller: usrnameCo,
                        hintText: 'Username',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      CoTextfield(
                        controller: emailCo,
                        hintText: 'Email',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      CoTextfield(
                        controller: passCo,
                        hintText: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 8 || value.length > 16) {
                            return 'Password must be between 8 and 16 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      CoTextfield(
                        controller: confirmCo,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passCo.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      CoButton(
                        text: "Register",
                        onTap: () => register(context),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 15,),
                          GestureDetector(
                            onTap: onTap,
                            child: Text(
                              "Login here",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.blue[300],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
