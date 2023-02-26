import 'package:hive/hive.dart';

class IntroDataBase {
  late bool data;
  final _mybox = Hive.box('mybox');

  void createInitialIntroData() {
    data = false;
  }

  void loadIntroData() {
    data = _mybox.get('intro');
  }

  void updateIntroDataBase() {
    _mybox.put('intro', true);
  }
}
