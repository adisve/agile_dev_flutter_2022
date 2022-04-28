import 'package:agile_dev_2022/widgets/card.dart';
import 'package:agile_dev_2022/task.dart';
import 'package:flutter/material.dart';
import 'package:agile_dev_2022/database/database.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<TaskPage> createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<TaskPage> {
  late List<ToDoItemData> ToDoItemList = [];
  final MyDB = MyDatabase();

  Future<ToDoItemData> getToDoItem(int toDoId) async {
    return await MyDB.getToDoItem(toDoId);
  }

  void getAllToDoItems() async {
    ToDoItemList = await MyDB.getAllToDoItems();
  }

  @override
  void initState() {
    getAllToDoItems();
    super.initState();
  }

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
                itemCount: ToDoItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskCard(
                    title: ToDoItemList[index].title,
                    description: ToDoItemList[index].description,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
