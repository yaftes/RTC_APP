import 'package:flutter/material.dart';
import 'package:rtc_app/auth/token.dart';
import 'package:rtc_app/components/co_button.dart';
import 'package:rtc_app/components/co_textfield.dart';
import 'package:rtc_app/services/userService.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> getUser(BuildContext context) async {
    user = await getUserFromPrefs(context);
    _emailController.text = user[0].email;
    _nameController.text = user[0].name;
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.blue[300]),
          ),
          backgroundColor: Colors.white,
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.blue[300]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                TokenStorage.deleteToken();
                removeUser();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Login(
                //       onTap: () {
                //         Navigator.of(context).pop();
                //       },
                //     ),
                //   ),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getUser(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
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
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
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
                    controller: _nameController,
                    hintText: 'name',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  CoTextfield(
                    controller: _emailController,
                    hintText: 'email',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  CoTextfield(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: false,
                  ),
                  SizedBox(height: 40),
                  CoButton(
                    text: "Update",
                    onTap: () {},
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
