import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:rtc_app/pages/login.dart';

class Register extends StatelessWidget {
  final void Function()? onTap;

  Register({super.key, required this.onTap});

  final TextEditingController usrnameCo = TextEditingController();
  final TextEditingController emailCo = TextEditingController();
  final TextEditingController passCo = TextEditingController();
  final TextEditingController ConfirmCo = TextEditingController();

  void register(BuildContext context) {
    // Add your registration logic here
    // For example, you might want to validate the inputs and make an API call

    // After successful registration, navigate to the login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login(onTap: onTap)),
    );
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
                    CoTextfield(controller: usrnameCo, hintText: 'Username', obscureText: false),
                    SizedBox(height: 15,),
                    CoTextfield(controller: emailCo, hintText: 'Email', obscureText: false),
                    SizedBox(height: 15,),
                    CoTextfield(controller: passCo, hintText: 'Password', obscureText: true),
                    SizedBox(height: 15,),
                    CoTextfield(controller: ConfirmCo, hintText: 'Password', obscureText: true),
                    SizedBox(height: 15,),
                    CoButton(
                      text: "Register",
                      onTap: () => register(context), // Pass the context to the register method
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
    );
  }
}