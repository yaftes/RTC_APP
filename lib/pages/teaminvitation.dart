
import 'package:flutter/material.dart';
import 'package:rtc_app/components/personcard.dart';

class TeamInvitation extends StatefulWidget {
  const TeamInvitation({super.key});

  @override
  State<TeamInvitation> createState() => _TeamInvitationState();
}

class _TeamInvitationState extends State<TeamInvitation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(child: Text("Notification")),
      ),
      body: Column(
        children: [
          PersonCard(name: "Haile", description:"bro", imageUrl: "", onTap: (){})
        ],
      ),
    );
  }
}