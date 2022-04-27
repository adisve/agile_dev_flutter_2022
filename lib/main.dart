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
<<<<<<< HEAD
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    MyDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "Test",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
=======
      home: const TaskPage(title: 'Flutter Demo Home Page'),
>>>>>>> 8406573400eac93331151f5cf17c07ce4d99bc4f
    );
  }
}
