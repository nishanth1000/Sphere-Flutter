import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../DataBase/introdatabase.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
            Icon(
              Icons.library_books_outlined,
              size: 220,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Notes',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '| Capture your Ideas |',
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
