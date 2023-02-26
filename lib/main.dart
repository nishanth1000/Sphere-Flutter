import 'package:flutter/material.dart';
import 'package:sphere/DataBase/introdatabase.dart';
import 'package:sphere/Main/home.dart';
import 'package:sphere/Main/overview.dart';
import 'package:sphere/onboarding_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mybox = Hive.box('mybox');
  IntroDataBase db = IntroDataBase();

  @override
  void initState() {
    super.initState();
    if (_mybox.get('intro') == null) {
      db.createInitialIntroData();
    } else {
      db.loadIntroData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: db.data ? '/' : '/intro',
      routes: {
        '/': (context) => const Home(),
        '/intro': (context) => const OnBoardingScreens(),
        '/overview': (context) => const OverView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
