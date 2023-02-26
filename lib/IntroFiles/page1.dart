import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../DataBase/introdatabase.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _mybox = Hive.box('mybox');
  IntroDataBase db = IntroDataBase();

  @override
  void initState() {
    super.initState();
    db.updateIntroDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.webhook_rounded,size: 220,),
            SizedBox(height: 30,),
            Text('Sphere',style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Text('To-Do | Habit-Tracker | Notes',style: TextStyle(color: Colors.black45,fontSize: 16),),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
