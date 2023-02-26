import 'package:hive/hive.dart';

class NotesDataBase {
  List data = [];
  final _mybox = Hive.box('mybox');

  void createInitialNotesData() {
    data = [
      [
        "Hello and welcome!\n\nIt's great to have you here.\n\nThis is a welcome message from Sphere. Thank you for downloading the application and being a part of our community. We believe that together we can achieve great things and make a positive impact. So, let's get started and make some amazing things happen!\n\nThank you :)\n"
      ],
    ];
  }

  void loadNotesData() {
    data = _mybox.get('notes');
  }

  void updateNotesDataBase() {
    _mybox.put('notes', data);
  }
}
