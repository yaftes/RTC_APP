import 'package:flutter/material.dart';
import 'package:rtc_app/components/co_createTeamForm.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:rtc_app/services/userService.dart';
import 'package:rtc_app/services/teamService.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  Future<void> _onAddButtonPressed() async {
    await getAllUsers();
  }

  @override
  void initState() {
    _onAddButtonPressed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(
            child: Text(
          'Team',
          style: TextStyle(color: Colors.white),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              showModalBottomSheet(
                elevation: 10,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return CreateTeamFormModal(
                      members: users,
                      onSubmit: (name, selectedMembers) async {
                        try {
                          Team team = Team(
                            owner: 1,
                            teamId: 1,
                            name: name,
                            members: selectedMembers,
                          );
                          await inviteUsers(team);
                          setState(() {
                            _onAddButtonPressed();
                          });
                        } catch (e) {
                          print('add object $e');
                        }
                        // setState(() {});
                      });
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Team>>(
        future: getTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Team> teams = snapshot.data!;
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(teams[index]
                      .name), 
                );
              },
            );
          }
        },
      ),
    );
  }
}
