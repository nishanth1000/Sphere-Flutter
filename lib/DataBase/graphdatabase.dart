import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:sphere/DataBase/date.dart';
import 'package:sphere/DataBase/month.dart';

class GraphDataBase {
  List data = [];
  Map points = {};
  List<FlSpot> allData = [];

  final _mybox = Hive.box('mybox');

  void createInitialGraphData() {
    points = {};
    _mybox.put('graphpoints', points);
    _mybox.put('month', int.parse(monthNo().toString()));
  }

  void loadGraphData() {
    double count = 0;
    points = {};

    if (_mybox.get('habits') == null) {
      data = [];
    } else {
      data = _mybox.get('habits');
    }

    for (int i = 0; i < data.length; i++) {
      if (data[i][1] == true) {
        count += 1;
      }
    }

    if (_mybox.get('graphpoints') == null) {
      points = {};
      _mybox.put('graphpoints', points);
    }

    if (double.parse(dayNo().toString()) == 1 ||
        _mybox.get('month') != int.parse(monthNo().toString())) {
      points = {};
      _mybox.put('graphpoints', points);
      _mybox.put('month', int.parse(monthNo().toString()));
    }

    points = _mybox.get('graphpoints');

    points[double.parse(dayNo().toString())] = count;

    _mybox.put('graphpoints', points);

    for (double z = 1.0; z <= double.parse(dayNo().toString()); z++) {
      if (!points.containsKey(z)) {
        points[double.parse(z.toString())] = 0.0;
      }
    }
    Map point = Map.fromEntries(
        points.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    allData = point.entries
        .map((e) => FlSpot(
            double.parse(e.key.toString()), double.parse(e.value.toString())))
        .toList();
  }
}
