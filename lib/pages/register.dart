import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';

class Register extends StatelessWidget {
 
   Register({super.key});
  final usrnameCo = TextEditingController();
  final emailCo = TextEditingController();
  final passCo = TextEditingController();
  final ConfirmCo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size:100,
                    color: Colors.black,
               ),
               SizedBox(height: 50,),
               Text("Welcome to our RTC App",
               style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
               ),),
              SizedBox(height: 20,),

              CoTextfield(controller: usrnameCo, hintText: 'Username', obscureText: false),
              SizedBox(height: 12,),
              CoTextfield(controller: emailCo, hintText: 'Email', obscureText: false),
              SizedBox(height: 12.0,),
              CoTextfield(controller: passCo, hintText: 'Password', obscureText: true),
              SizedBox(height: 12,),
              CoTextfield(controller: ConfirmCo, hintText: 'Password', obscureText: true),
              
            
              SizedBox(height: 15,),
              
              CoButton(text: "Register", onTap: (){}),
        
              const  SizedBox(height: 15,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),

                  GestureDetector(
                    onTap: (){},
                    child: Text("Login here",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
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
    ) ;
  }
}