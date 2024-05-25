import 'package:flutter/material.dart';

class CoTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CoTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 247, 247),
          border: Border(
            bottom: BorderSide(
              color: Colors.blue[300]!,
              width: 2,
            ),
            right: BorderSide(
              color: Colors.blue[300]!,
              width: 2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none, // Remove default border
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          ),
        ),
      ),
    );
  }
}
