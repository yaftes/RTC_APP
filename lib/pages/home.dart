import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Project Page'),
    Text('Calendar Page'),
    Text('Profile Page'),
  ];

  static const List<String> _titles = <String>[
    'RTC Home',
    'Projects',
    'Calendar',
    'Profile'
  ];
  static const List<Widget> _icons = <Widget>[
    Icon(
      Icons.account_tree_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.work_history_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.calendar_month_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.person_3,
      color: Colors.white,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            _titles.elementAt(_selectedIndex),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: _icons.elementAt(_selectedIndex),
          elevation: 50,
          backgroundColor: Colors.blue[300],
          centerTitle: true,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes_sharp),
            label: 'Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blue[200],
        selectedItemColor: const Color.fromARGB(255, 0, 200, 255),
        backgroundColor: const Color.fromARGB(255, 58, 118, 167),
        onTap: _onItemTapped,
      ),
    );
  }
}