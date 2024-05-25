import 'package:flutter/material.dart';

class CoButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CoButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

