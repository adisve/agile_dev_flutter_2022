import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/view/overview.dart';
import 'package:agile_dev_2022/view/task_page.dart';
import 'package:drift/drift.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {
  late Widget _taskPage;
  late List<Widget> _pages;
  late Widget _overviewPage;
  late int _currentIndex;
  late Widget _currentPage;
  @override
  void initState() {
    _currentIndex = 0;
    _taskPage = TaskPage();
    _overviewPage = Overview();
  _currentPage = TaskPage();
  _pages = [_taskPage, _overviewPage];





    super.initState();
  }

void changePage(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        resizeToAvoidBottomInset: false,
        body: _currentPage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changePage(index),
          currentIndex: _currentIndex,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.aod_rounded),label: 'Main Page'),
          BottomNavigationBarItem(icon: Icon(Icons.addchart_rounded),label: 'Overview Page'),
          ],
        ),
    ));
  }
}
