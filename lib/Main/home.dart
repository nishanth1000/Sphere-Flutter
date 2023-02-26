import 'package:flutter/material.dart';
import 'package:sphere/Main/habits.dart';
import 'package:sphere/Main/notes.dart';
import 'package:sphere/Main/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Sphere',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 19),
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'To-Do',
            ),
            Tab(
              text: 'Habits',
            ),
            Tab(
              text: 'Notes',
            ),
          ]),
          backgroundColor: Colors.black87,
          elevation: 0,
        ),
        body: const TabBarView(
          children: [ToDo(), Habits(), Notes()],
        ),
      ),
    );
  }
}
