import 'dart:developer';

import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/model/chartmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Overview extends StatefulWidget {
  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late TooltipBehavior _tooltipBehavior;
  late Map<String, int> _weekdaysAndTasksAccomplished = {
    "Monday": 0,
    "Tuesday": 0,
    "Wednesday": 0,
    "Thursday": 0,
    "Friday": 0,
    "Saturday": 0,
    "Sunday": 0
  };
  List<ChartModel>? _weekdaysAndFinishedTasksToChartModel;
  List<ChartModel>? _weekdaysAndUnfinishedTasksToChartModel;

  @override
  void initState() {
    middleMan();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  void middleMan() async {
    getFinishedTasksForWeek().then((weekChart) {
      setState(() {
        _weekdaysAndFinishedTasksToChartModel = weekChart;
      });
    });
    getUnfinishedTasksForWeek().then((weekChart) {
      setState(() {
        _weekdaysAndUnfinishedTasksToChartModel = weekChart;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _weekdaysAndFinishedTasksToChartModel != null
        ? Scaffold(
            body: Center(
            child: Container(
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Weekly overview'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: _tooltipBehavior,
                    series: <LineSeries<ChartModel, String>>[
                  LineSeries<ChartModel, String>(
                      color: Colors.greenAccent,
                      // Bind data source
                      dataSource: _weekdaysAndFinishedTasksToChartModel!,
                      xValueMapper: (ChartModel chartModel, _) =>
                          chartModel.weekday,
                      yValueMapper: (ChartModel chartModel, _) =>
                          chartModel.tasksAccomplished),
                  LineSeries<ChartModel, String>(
                      color: Colors.redAccent,
                      // Bind data source
                      dataSource: _weekdaysAndUnfinishedTasksToChartModel!,
                      xValueMapper: (ChartModel chartModel, _) =>
                          chartModel.weekday,
                      yValueMapper: (ChartModel chartModel, _) =>
                          chartModel.tasksAccomplished)
                ])),
          ))
        : Center(
            child: SpinKitWave(color: Color(0xFF1282DE)),
          );
  }

  Future<List<ChartModel>> getFinishedTasksForWeek() async {
    List<StashedTaskData> stashedTasks = await getAllStashedTasks();
    await Future.delayed(Duration(milliseconds: 500));

    for (var task in stashedTasks) {
      if (task.isDone!) {
        log(DateFormat('EEEE').format(DateTime.parse(task.createdDate!)));
        _weekdaysAndTasksAccomplished[
                DateFormat('EEEE').format(DateTime.parse(task.createdDate!))] =
            _weekdaysAndTasksAccomplished[DateFormat('EEEE')
                    .format(DateTime.parse(task.createdDate!))]! +
                1;
      }
    }
    List<ChartModel> temp = [];
    _weekdaysAndTasksAccomplished.forEach((key, value) {
      temp.add(ChartModel(key.substring(0, 3), value));
    });
    return temp;
  }

  Future<List<ChartModel>> getUnfinishedTasksForWeek() async {
    List<StashedTaskData> stashedTasks = await getAllStashedTasks();
    await Future.delayed(Duration(milliseconds: 500));

    for (var task in stashedTasks) {
      if (!task.isDone!) {
        log(DateFormat('EEEE').format(DateTime.parse(task.createdDate!)));
        _weekdaysAndTasksAccomplished[
                DateFormat('EEEE').format(DateTime.parse(task.createdDate!))] =
            _weekdaysAndTasksAccomplished[DateFormat('EEEE')
                    .format(DateTime.parse(task.createdDate!))]! +
                1;
      }
    }
    List<ChartModel> temp = [];
    _weekdaysAndTasksAccomplished.forEach((key, value) {
      temp.add(ChartModel(key.substring(0, 3), value));
    });
    return temp;
  }
}
