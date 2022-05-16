

import 'package:coba_crud/helpers/drawer_navigation.dart';
import 'package:coba_crud/screens/todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todolist'),
      ),
      drawer: Drawer_navigation(),
    floatingActionButton:
    FloatingActionButton(onPressed: ()=>Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>TodoScreen())),
      child: Icon(Icons.add),),
    // floatingActionButton: FloatingActionButton(onpressed,()){},
    );

  }
}
