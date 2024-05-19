import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';

class Register extends StatelessWidget {
 final void Function()? onTap;
   Register({super.key,required this.onTap});
  final TextEditingController usrnameCo = TextEditingController();
  final TextEditingController emailCo = TextEditingController();
  final TextEditingController passCo = TextEditingController();
  final TextEditingController ConfirmCo = TextEditingController();
   void register(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
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
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                     Container(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/pro.png")),
                 Text("Welcome to RTC App",
                 style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                 ),),
                SizedBox(height: 10,),
        
                CoTextfield(controller: usrnameCo, hintText: 'Username', obscureText: false),
                SizedBox(height: 15,),
                CoTextfield(controller: emailCo, hintText: 'Email', obscureText: false),
                SizedBox(height: 15,),
                CoTextfield(controller: passCo, hintText: 'Password', obscureText: true),
                SizedBox(height: 15,),
                CoTextfield(controller: ConfirmCo, hintText: 'Password', obscureText: true),
                
              
                SizedBox(height: 15,),
                
                CoButton(text: "Register", onTap:register),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?"),
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: onTap,
                      child: Text("Login here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
    ) ;
  }
}