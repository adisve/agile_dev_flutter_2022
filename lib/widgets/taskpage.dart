import 'package:agile_dev_2022/widgets/card.dart';
import 'package:agile_dev_2022/task.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<TaskPage> createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<TaskPage> {
  final List<Task> tasks = [
    Task("Studying", "Mathematics chapter one"),
    Task("Studying", "Mathematics chapter one"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: const [
                  Text(
                    "Today",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 18, 130, 222)),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    TaskCard(
                      title: tasks[index].title,
                      description: tasks[index].description,
                    ),
                    const Divider(
                      height: 15,
                      indent: 25,
                      endIndent: 25,
                    )
                  ]);
                },
              ),
            ),
          ],
        ));
  }
}
