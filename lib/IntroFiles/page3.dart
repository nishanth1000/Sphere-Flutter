import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.format_list_bulleted_rounded,size: 220,),
            SizedBox(height: 30,),
            Text('Habit Tracker',style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Text('| Build better Habits |',style: TextStyle(color: Colors.black45,fontSize: 16),),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
