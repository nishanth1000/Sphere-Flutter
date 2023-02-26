import 'package:hive/hive.dart';
import 'package:sphere/DataBase/date.dart';

class HabitsDataBase {
  List data = [];
  List habitsdata = [];

  final _mybox = Hive.box('mybox');

  void createInitialHabitsData() {
    data = [
      ['Example Habit', false],
    ];

    _mybox.put('Start_Date', todaysDate());
  }

  void loadHabitsData() {
    if (_mybox.get(todaysDate()) == null) {
      data = _mybox.get('habits');
      for (int i = 0; i < data.length; i++) {
        data[i][1] = false;
      }
    } else {
      data = _mybox.get(todaysDate());
    }
  }

  void updateHabitsDataBase() {
    _mybox.put(todaysDate(), data);
    _mybox.put('habits', data);
  }
}
