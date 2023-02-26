import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sphere/DataBase/notesdatabase.dart';


class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _mybox = Hive.box('mybox');
  NotesDataBase db = NotesDataBase();

  final notesController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(_mybox.get('notes') == null){
      db.createInitialNotesData();
    }
    else{
      db.loadNotesData();
    }
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        db.data.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: db.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          onTap: null,
                          title: Text(
                            db.data[index][0],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                db.data.removeAt(index);
                                db.updateNotesDataBase();
                              });
                            },
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
                        'Currently no Notes :(',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: SizedBox(
                height: 48,
                width: 150,
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: notesController,
                  cursorColor: Colors.red,
                  cursorHeight: 22,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    labelText: 'Enter your Note',
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(100)
                  //more than 50% of width makes circle
                  ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (notesController.text != '') {
                      db.data.add([notesController.text]);
                      db.updateNotesDataBase();
                      notesController.text = '';
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  });
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        const SizedBox(
          height: 9,
        ),
      ],
    );
  }
}
