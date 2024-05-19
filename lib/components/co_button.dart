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
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 186, 186, 94),
            borderRadius: BorderRadius.circular(10)
          ),
          padding:  EdgeInsets.all(15)   ,
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