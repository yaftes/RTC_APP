import 'package:flutter/material.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:rtc_app/services/projectService.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rtc_app/services/teamService.dart';

class UpdateProjectForm extends StatefulWidget {
  final BuildContext context;
  final Project project;
  final Function() onUpdate;
  UpdateProjectForm(
      {required this.onUpdate, required this.project, required this.context});

  @override
  _UpdateProjectFormState createState() => _UpdateProjectFormState();
}

class _UpdateProjectFormState extends State<UpdateProjectForm> {
  List<Team> selectedTeams = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<Team> teams = [];

  @override
  void initState() {
    print(' update form');
    if (widget.project.teams != null) {
      widget.project.teams.forEach((el) {
        selectedTeams
            .add(Team(members: el.members, name: el.name, teamId: el.teamId));
      });
    }
    super.initState();
    _titleController.text = widget.project.title;
    _descriptionController.text = widget.project.description;
  }

  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Update existing Project",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Update existing project!",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Project Title',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Project description',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MultiTeamSelect(
                onTeamsSelected: (val) => setState(() {
                  teams = val;
                }),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              bool created = await createProject(Project(
                  projectId: 0,
                  description: _descriptionController.text,
                  title: _titleController.text,
                  teams: teams));
              if (created) {
                widget.onUpdate();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Project created successfully'),
                  backgroundColor: Colors.green,
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Failed to create project'),
                    backgroundColor: Colors.red));
              }
            },
            child: Text("Update Project"),
          ),
        ],
      ),
    );
  }
}

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
