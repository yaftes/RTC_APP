import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtc_app/model/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/token.dart';

var url = '127.0.0.1:8000';

List<User> user = [User(userId: -1, name: 'null', email: 'null')];

final List<User> usersInProject = [];
Future<List<User>> getUsersInProject(int projectId) async {
  usersInProject.clear();
  var accessToken = await TokenStorage.getAccessToken();
  try {
    var response = await http.get(
      Uri.http('$url', 'teams-in-project/$projectId'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      var members = jsonDecode(response.body);

      for (var eachMember in members) {
        final member = User(
          userId: eachMember['id'],
          name: eachMember['name'],
          email: eachMember['email'],
        );
        // print(member);
        usersInProject.add(member);
      }
    } else {
      print('error');
    }
  } catch (e) {
    print(e);
  }
  return usersInProject;
}

Future<bool> userLogin(String email, String password) async {
  bool login = false;

  Map<String, dynamic> userData = {
    'email': email,
    'password': password,
  };

  try {
    var response = await http.post(
      Uri.parse('http://$url/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    Map<String, dynamic> token = jsonDecode(response.body);
    if (response.statusCode == 200) {
      login = true;
      print('Login successfully');

      await TokenStorage.setToken(token['access'], token['refresh']);
    } else {
      print('Failed to Login user');
    }
  } catch (error) {
    print('Error loging in user: $error');
  }
  return login;
}

Future<bool> storeUser() async {
  User user;
  var accessToken = await TokenStorage.getAccessToken();
  try {
    var response = await http.get(
      Uri.http('$url', 'auth/user/'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      var userJson = jsonDecode(response.body)[0];
      user = User.fromJson(userJson);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));
      print('user successfully stored');
      // print(user);
    } else {
      
      print('user fetching error');
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }

  return true;
}

Future<void> removeUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
}

Future<List<User>> getUserFromPrefs(BuildContext context) async {
  user.clear();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User storedUser = User(userId: -1, name: 'null', email: 'null');
  String? userJson = prefs.getString('user');
  if (userJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    storedUser = User.fromJson(userMap);
  } else {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/login');
  }
  // print('${storedUser.email} oehbcbfbvnbvnvnvnvnvnvnvj');
  user.add(storedUser);
  return user;
}

