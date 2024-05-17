import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';

class Login extends StatelessWidget {
 
   Login({super.key});
  final usrnameCo = TextEditingController();
  final passCo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size:80,
                color: Colors.black,
           ),
           SizedBox(height: 50,),
           Text('RTC DEMO APP',
           style: TextStyle(
            color: Colors.grey,
            fontSize: 16
           ),),
          SizedBox(height: 25,),
          CoTextfield(controller: usrnameCo, hintText: 'Username', obscureText: false),
          SizedBox(height: 25.0,),
          CoTextfield(controller: passCo, hintText: 'Password', obscureText: true),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Forgot Password?",)
            ],
          ),
          SizedBox(height: 25,),
          
          CoButton(text: "Login", onTap: (){})

           
        
            ],
          ),
        ),
      ),
    ) ;
  }
}