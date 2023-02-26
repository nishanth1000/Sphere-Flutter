import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sphere/DataBase/date.dart';
import 'package:sphere/DataBase/graphdatabase.dart';

class OverView extends StatefulWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  final _mybox = Hive.box('mybox');
  GraphDataBase db = GraphDataBase();

  @override
  void initState() {
    if (_mybox.get('graphpoints') == null) {
      db.createInitialGraphData();
    } else {
      db.loadGraphData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Habits Summary',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 19),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: AspectRatio(
                aspectRatio: 2,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    minY: 0.0,
                    minX: 0.0,
                    maxX: double.parse(dayNo()) + 1.0,
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        axisNameWidget: const Text('Days'),
                      ),
                      rightTitles: AxisTitles(
                        axisNameWidget: const Text('Frequency'),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: Colors.green,
                        spots: db.allData,
                        isCurved: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "The above Graph displays the Habit Summary for this month.\nIt displays the Number of Habits completed vs The Date. This Graph is flushed at the start of the New Month, so that the graph displays that particular Month's Habit Completetion. ",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Rotate the device for detailed graph.",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
