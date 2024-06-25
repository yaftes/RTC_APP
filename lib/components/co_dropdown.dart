import 'package:flutter/material.dart';
import 'package:rtc_app/model/objects.dart';
// Assuming the DropdownItem class is defined above or imported

class CustomDropdown extends StatefulWidget {
  final List<DropdownItem> teams;
  final String hintText;

  CustomDropdown({required this.teams, required this.hintText});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownMenuItems = widget.teams.map((team) {
      return DropdownMenuItem<String>(
        value: team.name,
        child: Text(team.name),
      );
    }).toList();

    return DropdownButton<String>(
      hint: Text(widget.hintText),
      value: selectedValue,
      items: dropdownMenuItems,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
    );
  }
}

