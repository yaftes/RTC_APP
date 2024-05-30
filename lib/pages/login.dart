import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  final void Function()? onTap;
  Login({super.key, required this.onTap});

  final TextEditingController usrnameCo = TextEditingController();
  final TextEditingController passCo = TextEditingController();



  void authenticate(BuildContext context) async {
    final storage = FlutterSecureStorage();

    String email = usrnameCo.text;
    String password = passCo.text;
    Map<String, dynamic> userData = {
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/token/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      Map<String, dynamic> token = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Login successfully');
        print(token);

        String access_token = token['access'], refresh_token = token['refresh'];

        await storage.write(key: 'access_token', value: access_token);
        await storage.write(key: 'refresh_token', value: refresh_token);

        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        print('Failed to Login user');
      }
    } catch (error) {
      print('Error loging in user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.all(20.0),
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
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 25),
                    CoTextfield(
                      controller: usrnameCo,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: 25.0),
                    CoTextfield(
                      controller: passCo,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?"),
                      ],
                    ),
                    SizedBox(height: 25),
                    CoButton(
                      text: "Login",
                      onTap: () => authenticate(context),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: onTap,
                          child: Text(
                            "Register here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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


