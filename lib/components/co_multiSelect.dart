// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rtc_app/services/teamService.dart';

import '../model/objects.dart';

typedef TeamCallback = void Function(List<Team> teams);

class MultiTeamSelect extends StatefulWidget {
  final TeamCallback onTeamsSelected;

  MultiTeamSelect({super.key, required this.onTeamsSelected});

  @override
  _MultiTeamSelectState createState() => _MultiTeamSelectState();
}

class _MultiTeamSelectState extends State<MultiTeamSelect> {
  List<MultiSelectItem<Team>> _teams = [];
  List<Team> _selectedTeams = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  void buildDropDownTeam() async {
    try {
      List<Team> teams = await getTeams();
      _teams =
          teams.map((team) => MultiSelectItem<Team>(team, team.name)).toList();
      setState(() {});
      print('Teams: $_teams');
    } catch (e) {
      print('Error fetching teams $e');
    }
  }

  @override
  void initState() {
    buildDropDownTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: _teams,
      title: Text("Teams"),
      selectedColor: const Color.fromARGB(255, 98, 184, 255),
      selectedItemsTextStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        border: Border.all(
          color: Colors.blue,
          width: 0.4,
        ),
        
      ),
      listType: MultiSelectListType.CHIP,
      searchable: true,
      buttonIcon: Icon(
        Icons.add_circle_outline,
        color: Colors.blue,
      ),
      buttonText: Text(
        "Add Teams",
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 16,
        ),
      ),
      onConfirm: (results) {
        _selectedTeams = results;
        widget.onTeamsSelected(results);
      },
    );
  }
}
