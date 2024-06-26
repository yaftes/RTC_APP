import 'package:flutter/material.dart';
import 'package:rtc_app/pages/teamInvitation.dart';

import 'team.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remove debug banner
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, // Extend body behind AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.blue[300],
          titleSpacing: 0,
          automaticallyImplyLeading: false, // Remove automatic leading icon
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu), // Drawer icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer on icon tap
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Haile!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Circular Avatar example
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/avatar.png'), // Replace with your avatar image asset
                radius: 20,
              ),
            ),
            // Search icon button
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
              child: Center(
                child: Text(
                  'RTC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notification_add),
              ),
              title: Text('Notification'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeamInvitationPage()),
                );
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.person),
              ),
              title: Text('Team'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: 'Think &\n',
                                style: TextStyle(color: Colors.orange)),
                            TextSpan(
                                text: 'Schedule Your\n',
                                style: TextStyle(color: Colors.green)),
                            TextSpan(
                                text: 'Daily Tasks',
                                style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 100,
                        alignment: Alignment.center, // Center align the image
                        child: Image.asset(
                          'assets/tree.jpg',
                          fit: BoxFit
                              .cover, // Cover the entire container without distortion
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart),
                        SizedBox(width: 10),
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(255, 224, 218, 218),
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCircleWithColor(Colors.orange, '3', 'In-Process'),
                      _buildCircleWithColor(Colors.green, '125', 'Completed'),
                      _buildCircleWithColor(Colors.blue, '139', 'Total'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_graph),
                        SizedBox(width: 10),
                        Text(
                          'Task Completion Graph',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/graph.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleWithColor(Color color, String text, String helloText) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 5),
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          helloText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Suggestion 1'),
          onTap: () {
            query = 'Suggestion 1';
            showResults(context);
          },
        ),
        ListTile(
          title: Text('Suggestion 2'),
          onTap: () {
            query = 'Suggestion 2';
            showResults(context);
          },
        ),
      ],
    );
  }
}
