import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sphere/DataBase/tododatabase.dart';


class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  final todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_mybox.get('todo') == null) {
      db.createInitialToDoData();
    } else {
      db.loadToDoData();
    }
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
                children: [
                  db.data.isNotEmpty
                      ?Expanded(
                    child: ListView.builder(
                        itemCount: db.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: null,
                              leading: IconButton(
                                icon: db.data[index][1]
                                    ? const Icon(Icons.check_box_rounded)
                                    : const Icon(
                                        Icons.check_box_outline_blank_rounded),
                                onPressed: () {
                                  setState(() {
                                    if (db.data[index][1] == false) {
                                      db.data[index][1] = true;
                                      db.updateToDoDataBase();
                                    } else {
                                      db.data[index][1] = false;
                                      db.updateToDoDataBase();
                                    }
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
                              trailing: IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    db.data.removeAt(index);
                                    db.updateToDoDataBase();
                                  });
                                },
                              ),
                            ),
                          );
                        }),
                  ):Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: Text(
                            'Currently no To-Do :)',
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
                            textCapitalization: TextCapitalization.words,
                            controller: todoController,
                            cursorColor: Colors.red,
                            cursorHeight: 22,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                ),
                              ),
                              labelText: 'Enter your To-Do',
                              labelStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
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
                              if (todoController.text != '') {
                                db.data.add([todoController.text, false]);
                                db.updateToDoDataBase();
                                todoController.text = '';
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
              )
            );
  }
}
