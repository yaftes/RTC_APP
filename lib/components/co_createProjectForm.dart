
import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_multiSelect.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:rtc_app/services/projectService.dart';


class CreateProjectForm extends StatefulWidget {
  final Function() onCreate;
  CreateProjectForm({required this.onCreate});

  @override
  _CreateProjectFormState createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<Team> teams = [];

  @override
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
            "Create New Project",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Let's Collaborate and Create exciting new project together!",
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
              // Stack(
              //   fit: StackFit.loose,
              //   clipBehavior: Clip.none,
              //   children: <Widget>[
              //     Positioned(
              //       left: -50.0,
              //       child: CircleAvatar(
              //         backgroundColor: Color.fromARGB(255, 11, 129, 175),
              //         child: Text('AH'),
              //       ),
              //     ),
              //     Positioned(
              //       left: -30.0,
              //       child: CircleAvatar(
              //         backgroundColor: Color.fromARGB(255, 66, 138, 255),
              //         child: Text('MM'),
              //       ),
              //     ),
              //     CircleAvatar(
              //       backgroundColor: Color.fromARGB(255, 90, 85, 240),
              //       child: Text('AH'),
              //     ),
              //   ],
              // ),
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
                widget.onCreate();
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
            child: Text("Create Project"),
          ),
        ],
      ),
    );
  }
}
