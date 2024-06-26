import 'package:flutter/material.dart';
import 'package:rtc_app/components/personcard.dart';
import 'package:rtc_app/components/personcardAccepted.dart';
import 'package:rtc_app/model/objects.dart';
import 'package:rtc_app/services/teamService.dart';

class TeamInvitationPage extends StatefulWidget {
  const TeamInvitationPage({super.key});

  @override
  State<TeamInvitationPage> createState() => _TeamInvitationPageState();
}

class _TeamInvitationPageState extends State<TeamInvitationPage> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refreshInvitations() async {
    await getInvitations();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(child: Text("Notification")),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshInvitations,
        child: FutureBuilder(
          future: getInvitations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  return invitations[index].isAccepted
                      ? PersonCardAccepted(
                          name: 'invited to ${invitations[index].team.name}',
                          description: "Accept to join the team",
                          imageUrl: "",
                        )
                      : PersonCard(
                          name: 'invited to ${invitations[index].team.name}',
                          description: "Accept to join the team",
                          imageUrl: "",
                          onTap: () {
                            acceptInvitation(invitations[index]);
                            setState(() {});
                          });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
