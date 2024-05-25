import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'calendar_page.dart';
import 'profile_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // Create instances of the page widgets
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProjectPage(),
    CalendarPage(),
    ProfilePage(),
  ];

  // Titles for the AppBar
  static const List<String> _titles = <String>[
    'Home',
    'Project',
    'Calendar',
    'Profile',
  ];

  // Icons for the AppBar
  static const List<Widget> _icons = <Widget>[
    Icon(Icons.home),
    Icon(Icons.track_changes_sharp),
    Icon(Icons.calendar_month_outlined),
    Icon(Icons.person),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 10),
        curve: Curves.ease,
      );
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions, // Pass the list of pages as children
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
