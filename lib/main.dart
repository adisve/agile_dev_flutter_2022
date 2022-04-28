import 'package:agile_dev_2022/widgets/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:agile_dev_2022/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskPage(title: 'Flutter Demo Home Page'),
    );
  }
}
