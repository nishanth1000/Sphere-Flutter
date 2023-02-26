import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inventory_outlined,size: 220,),
            SizedBox(height: 30,),
            Text('To-Do',style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Text('| Unlock your Potential |',style: TextStyle(color: Colors.black45,fontSize: 16),),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}