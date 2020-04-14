import 'package:flutter/material.dart';
import 'package:latest_tech_updates/Screens/Opportunities.dart';
import 'package:latest_tech_updates/Screens/certifications.dart';
import 'package:latest_tech_updates/Screens/resources.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final _pageOptions =[
    Resources(),
    Opportunity(),
    certification(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex=index;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            title:Text('Resources'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop_mac),
            title:Text('Opportunities'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            title:Text('Certifications'),
          ),
        ],
      ),
      body: IndexedStack(
          children: _pageOptions,
        index: _selectedIndex,
      ),
    );
  }
}
