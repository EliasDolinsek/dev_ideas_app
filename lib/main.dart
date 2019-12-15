import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:dev_ideas/features/dev_projects/presentation/widgets/home_layout.dart';
import 'package:path_provider/path_provider.dart';
import 'injection_container.dart' as di;

void main(){
  di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevProjects',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _selectedIndex = 0;

  static const items = const [
    HomeLayout(),
    Text("SETTINGS"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DevProjects", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: items.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          )
        ],
        onTap: _onTap,
        currentIndex: _selectedIndex,      	 
	)
    );
  }

  void _onTap(int index){
    setState((){
      _selectedIndex = index;
    });
  }
}
