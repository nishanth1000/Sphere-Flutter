import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../DataBase/habitsdatabase.dart';
import '../DataBase/introdatabase.dart';

class Habits extends StatefulWidget {
  const Habits({Key? key}) : super(key: key);

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  final _mybox = Hive.box('mybox');
  HabitsDataBase db = HabitsDataBase();
  IntroDataBase dbintro = IntroDataBase();
  List<FlSpot> points = [];
  final habitsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_mybox.get('habits') == null) {
      db.createInitialHabitsData();
    } else {
      db.loadHabitsData();
    }
    dbintro.updateIntroDataBase();
  }

  @override
  void dispose() {
    habitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            db.data.isNotEmpty
                ? Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: db.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () => _editdialogBuilder(
                                  context, db.data[index][0], index),
                              leading: IconButton(
                                icon: db.data[index][1]
                                    ? const Icon(Icons.check_box_rounded)
                                    : const Icon(
                                        Icons.check_box_outline_blank_rounded),
                                onPressed: () {
                                  setState(() {
                                    if (db.data[index][1] == false) {
                                      db.data[index][1] = true;
                                      db.updateHabitsDataBase();
                                    } else {
                                      db.data[index][1] = false;
                                      db.updateHabitsDataBase();
                                    }
                                  });
                                },
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    db.data.removeAt(index);
                                    db.updateHabitsDataBase();
                                  });
                                },
                              ),
                              title: Text(
                                db.data[index][0],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  decoration: db.data[index][1]
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: Text(
                            'Currently no Habits :(',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: 'btn1',
              onPressed: () => Navigator.pushNamed(context, '/overview'),
              backgroundColor: Colors.black,
              child: const Icon(Icons.summarize_rounded),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'btn2',
              onPressed: () => _createdialogBuilder(context),
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }

  Future<void> _createdialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Habit'),
          content: TextField(
            textCapitalization: TextCapitalization.words,
            controller: habitsController,
            cursorColor: Colors.red,
            cursorHeight: 22,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24.0),
                ),
              ),
              labelText: 'Habit Name',
              labelStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                setState(() {
                  if (habitsController.text != '') {
                    Navigator.pop(context);
                    db.data.add([habitsController.text, false]);
                    db.updateHabitsDataBase();
                    habitsController.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editdialogBuilder(
      BuildContext context, String habitName, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Habit',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                habitName,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
            ],
          ),
          content: TextField(
            textCapitalization: TextCapitalization.words,
            controller: habitsController,
            cursorColor: Colors.red,
            cursorHeight: 22,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24.0),
                ),
              ),
              labelText: 'New Habitname',
              labelStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'), //cancel or save
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  if (habitsController.text != '') {
                    db.data[index][0] = habitsController.text;
                    habitsController.text = '';
                    db.updateHabitsDataBase();
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
