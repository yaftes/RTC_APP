import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatelessWidget {
  final void Function()? onTap;
  Register({super.key, required this.onTap});

  final TextEditingController usrnameCo = TextEditingController();
  final TextEditingController emailCo = TextEditingController();
  final TextEditingController passCo = TextEditingController();
  final TextEditingController ConfirmCo = TextEditingController();

  void register() async {
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
        onTap?.call();
      } else {
        print('Failed to register user');
      }
    } catch (error) {
      print('Error registering user: $error');
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
              Colors.tealAccent,
              Colors.cyan,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 250,
                        height: 250,
                        child: Image.asset("assets/pro.png")),
                    SizedBox(height: 35),
                    Text(
                      "Welcome to our RTC App",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CoTextfield(
                        controller: usrnameCo,
                        hintText: 'Username',
                        obscureText: false),
                    SizedBox(
                      height: 12,
                    ),
                    CoTextfield(
                        controller: emailCo,
                        hintText: 'Email',
                        obscureText: false),
                    SizedBox(
                      height: 12.0,
                    ),
                    CoTextfield(
                        controller: passCo,
                        hintText: 'Password',
                        obscureText: true),
                    SizedBox(
                      height: 12,
                    ),
                    CoTextfield(
                        controller: ConfirmCo,
                        hintText: 'Password',
                        obscureText: true),
                    SizedBox(
                      height: 15,
                    ),
                    CoButton(text: "Register", onTap: register),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ?"),
                        GestureDetector(
                          onTap: onTap,
                          child: Text(
                            "Login here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
