import 'package:hive/hive.dart';

class ToDoDataBase {
  List data = [];
  final _mybox = Hive.box('mybox');

  void createInitialToDoData() {
    data = [
      ['Unchecked To-Do', false],
      ['Checked To-Do', true],
    ];
  }

  void loadToDoData() {
    data = _mybox.get('todo');
  }

  void updateToDoDataBase() {
    _mybox.put('todo', data);
  }
}
