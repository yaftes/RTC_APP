import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_card.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:rtc_app/pages/login.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // remove border-radius
          ),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.blue[300]),
          ),
          backgroundColor: Colors.white, // change background color
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.blue[300]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.green), // change color to green
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red), // change color to red
              ),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: 50,
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white, // change icon color to white
              ),
              onPressed: () {
                _showLogoutDialog(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.blue[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                SizedBox(height: 40),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(height: 40),
                  CoTextfield(
                    controller: _emailController,
                    hintText: 'Username',
                    obscureText: false,
                    // change text color to white
                  ),
                  SizedBox(height: 20),
                  CoTextfield(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: false,
                  ),
                  SizedBox(height: 40),
                  CoButton(
                    text: "Register",
                    onTap: () {}, // Pass the context to the register method
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
