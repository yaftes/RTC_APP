import 'package:flutter/material.dart';
import 'package:rtc_app/auth/loginorregister.dart';
import 'package:rtc_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     ),
      home: Loginorregister(),
      routes: {
        '/home' : (context)=> MyHomePage(),
      },
    );
  }
}

