import 'package:flutter/material.dart';

class CoButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CoButton({
    super.key,
    required this.text,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12)
          ),
          padding:  EdgeInsets.all(20),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white
                            ),
      
            ),
          ),
        ),
      ),
    );
  }
}