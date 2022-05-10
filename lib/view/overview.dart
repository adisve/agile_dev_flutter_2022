import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class Overview extends StatefulWidget {
  @override
  State<Overview> createState() => _OverviewState();
  
  
}

class _OverviewState extends State<Overview>{ 
  late TooltipBehavior _tooltipBehavior;

@override
void initState(){
  _tooltipBehavior = TooltipBehavior(enable: true);
  super.initState();
}
  @override
Widget build(BuildContext context) {
  return Scaffold(
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
            series: <LineSeries<TodoModel, String>>[
              LineSeries<TodoModel, String>(
                // Bind data source
                dataSource:  <TodoModel>[
                TodoModel(2, 'studying', 'ath', 2, '', false, false),
                TodoModel(2, 'studyi', 'mat', 2, '', false, false),
                TodoModel(2, 'sying', 'math', 2, '', false, false),
                TodoModel(3, 'st', 'mth', 2, '', false, false)
                ],
                xValueMapper: (TodoModel task, _) => task.title,
                yValueMapper: (TodoModel task, _) => task.id
              )
            ]
          )
        )
      )
  );
}

}

