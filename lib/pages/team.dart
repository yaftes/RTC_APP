import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  void _onAddButtonPressed() {
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(child: Text('Team',style: 
        TextStyle(
          color: Colors.white
        ),)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,),
            onPressed: () {
              _onAddButtonPressed();
            },
          ),
        ],
      ),
      body: Center(
        
      ),
    );
  }
}

