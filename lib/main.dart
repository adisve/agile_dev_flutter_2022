import 'package:agile_dev_2022/database/database.dart';
import 'package:agile_dev_2022/widgets/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void main() {
  setup();
  runApp(const MyApp());
}

/// Initialise global instance of database instead of locally
/// creating variables in individual classes
void setup() {
  locator.registerSingleton<MyDatabase>(MyDatabase());
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
