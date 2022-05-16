import 'dart:developer';

import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:agile_dev_2022/view/overview.dart';
import 'package:agile_dev_2022/view/task_page.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

final locator = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

/// Initialise global instance of database instead of locally
/// creating variables in individual classes.
void setup() async {
  locator.registerSingleton<MyDatabase>(MyDatabase());
  getAllStashedTasks().then((_stashedTasksList) {
    for (var task in _stashedTasksList) {
      if (DateTime.now().weekOfYear !=
          DateTime.parse(task.createdDate!).weekOfYear) {
        deleteStashedTask(task);
      }
    }
  });

  // Set window sizes
  await DesktopWindow.setWindowSize(Size(1280, 720));
  await DesktopWindow.setMinWindowSize(Size(400, 400));
  await DesktopWindow.setMaxWindowSize(Size(1920, 1080));
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
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 192, 216, 235),
          backgroundColor: Color.fromRGBO(233, 241, 247, 1.0),
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _currentPage,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 192, 216, 235),
            elevation: 50,
            unselectedItemColor: Color.fromRGBO(99, 112, 116, 1.0),
            selectedItemColor: Color.fromARGB(255, 56, 57, 57),
            onTap: (index) => changePage(index),
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.aod_rounded), label: 'Main Page'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.addchart_rounded), label: 'Overview Page'),
            ],
          ),
        ));
  }
}
