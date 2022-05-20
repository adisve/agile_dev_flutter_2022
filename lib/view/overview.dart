import 'dart:developer';

import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/model/chartmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late Map<String, int> _weekdaysAndTasksNotAccomplished = {
    "Monday": 0,
    "Tuesday": 0,
    "Wednesday": 0,
    "Thursday": 0,
    "Friday": 0,
    "Saturday": 0,
    "Sunday": 0
  };

  late Map<String, int> _weekdaysAndMentalStateReport = {
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
  List<ChartModel>? _weekdaysAndMentalStateReportToChartModel;

  @override
  void initState() {
    if (mounted) {
      middleMan();
    }

    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  void middleMan() async {
    getFinishedTasksForWeek().then((weekChart) {
      if (mounted) {
        setState(() {
          _weekdaysAndFinishedTasksToChartModel = weekChart;
        });
      }
    });
    getUnfinishedTasksForWeek().then((weekChart) {
      if (mounted) {
        setState(() {
          _weekdaysAndUnfinishedTasksToChartModel = weekChart;
        });
      }
    });
    getMentalStateReportForWeek().then((weekChart) {
      if (mounted) {
        setState(() {
          _weekdaysAndMentalStateReportToChartModel = weekChart;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return _weekdaysAndFinishedTasksToChartModel != null
        ? Scaffold(
            body: Center(
            child: Container(
                child: SfCartesianChart(
                    plotAreaBorderColor: Color.fromRGBO(33, 34, 39, 1.0),
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(
                        text: 'Weekly overview',
                        textStyle: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Color.fromRGBO(33, 34, 39, 1.0))),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: _tooltipBehavior,
                    series: <CartesianSeries>[
                            ColumnSeries<ChartModel, String>(
                                name: "Completed tasks",
                                legendItemText: "Completed tasks",
                                enableTooltip: true,
                                color: Color.fromRGBO(239, 156, 218, 0.937),
                                // Bind data source
                                dataSource: _weekdaysAndFinishedTasksToChartModel!,
                                xValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.weekday,
                                yValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.tasksAccomplished
                            ),
                             ColumnSeries<ChartModel, String>(
                                name: "Unfinished Tasks",
                                enableTooltip: true,
                                legendItemText: "Unfinished Tasks",
                                color: Color.fromRGBO(137, 161, 239, 0.937),
                                // Bind data source
                                dataSource: _weekdaysAndUnfinishedTasksToChartModel!,
                                xValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.weekday,
                                yValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.tasksAccomplished
                            ),
                            LineSeries<ChartModel, String>(
                                name: "Mental State",
                                legendItemText: "Mental State",
                                enableTooltip: true,
                                color: Color.fromARGB(236, 238, 239, 156),
                                // Bind data source
                                dataSource: _weekdaysAndMentalStateReportToChartModel!,
                                xValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.weekday,
                                yValueMapper: (ChartModel chartModel, _) =>
                                  chartModel.tasksAccomplished
                            ),
                        
                  
                ]    
                )),
          ))
        : Center(
            child: SpinKitWave(color: Color(0xFF1282DE)),
          );
  }

  
  Future<List<ChartModel>> getMentalStateReportForWeek() async {
    List<MentalStateReportData> mentalStateReports = await getAllMentalStateReports();
    await Future.delayed(Duration(milliseconds: 500));

    for (var report in mentalStateReports) {
      int mentalState = report.value ?? 0;
      if (mentalState != 0) {
        log(DateFormat('EEEE').format(DateTime.parse(report.createdDate!)));
        _weekdaysAndMentalStateReport[
                DateFormat('EEEE').format(DateTime.parse(report.createdDate!))] = mentalState;
      }
    }
    List<ChartModel> temp = [];
    _weekdaysAndMentalStateReport.forEach((key, value) {
      temp.add(ChartModel(key.substring(0, 3), value));
    });
    return temp;
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
        _weekdaysAndTasksNotAccomplished[
                DateFormat('EEEE').format(DateTime.parse(task.createdDate!))] =
            _weekdaysAndTasksNotAccomplished[DateFormat('EEEE')
                    .format(DateTime.parse(task.createdDate!))]! +
                1;
      }
    }
    List<ChartModel> temp = [];
    _weekdaysAndTasksNotAccomplished.forEach((key, value) {
      temp.add(ChartModel(key.substring(0, 3), value));
    });
    return temp;
  }
}
