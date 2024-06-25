import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rtc_app/model/objects.dart';

import '../services/teamService.dart';

class MultiTeamSelect extends StatefulWidget {
  @override
  _MultiTeamSelectState createState() => _MultiTeamSelectState();
}

class _MultiTeamSelectState extends State<MultiTeamSelect> {
  List<MultiSelectItem<Team>> _teams = [];
  void buildDropDownTeam() async {
    try {
      List<Team> teams = await getTeams();
      _teams = teams
          .map((animal) => MultiSelectItem<Team>(animal, animal.name))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  List<Team> _selectedTeams = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    _selectedTeams = teams;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
