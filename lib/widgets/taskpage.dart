import 'dart:math';

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
  List<ToDoItemData> CheckedItems = [];
  late List<ToDoItemData> ToDoItemList = [];
  final MyDB = MyDatabase();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.all(8));
  String valueText = "";
  String toDoTitle = "";
  String toDoDescription = "";
  final controller = TextEditingController();

  Future<ToDoItemData> getToDoItem(int toDoId) async {
    return await MyDB.getToDoItem(toDoId);
  }

  void getAllToDoItems() async {
    var temp = await MyDB.getAllToDoItems();
    setState(() {
      ToDoItemList = temp;
    });
  }

  void updateCheckedList(ToDoItemData ToDoItem) {
    setState(() {
      CheckedItems.add(ToDoItem);
    });
  }

  void removeCheckedList() {
    for (var item in CheckedItems) {
      MyDB.deleteToDoItem(item.toCompanion(true));
    }
    setState(() {
      CheckedItems = [];
      getAllToDoItems();
    });
  }

  @override
  void initState() {
    getAllToDoItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 35, bottom: 10),
              alignment: Alignment.topLeft,
              child: const Text(
                "Today",
                maxLines: 2,
                style: TextStyle(
                    fontSize: 40, color: Color.fromARGB(255, 18, 130, 222)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: ToDoItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    TaskCard(
                      notifyParent: updateCheckedList,
                      toDoItem: ToDoItemList[index],
                    ),
                    Divider(
                      indent: 35,
                      endIndent: 35,
                      height: 15,
                    )
                  ]);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      removeCheckedList();
                    },
                    child: Icon(Icons.delete),
                  )),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      createTask(context, controller);
                    },
                    child: Icon(Icons.add),
                  )),
            ),
          ],
        ));
  }

  void createTask(
      BuildContext context, TextEditingController controller) async {
    await showCreateToDoItem(context, controller);
    if (toDoTitle == "") {
      return;
    }
    addToDoItems(
        ToDoItemData(id: Random.secure().nextInt(1234), title: toDoTitle));
    setState(() {
      toDoTitle = "";
    });
    updateScreen();
  }

  Future<void> showCreateToDoItem(
      BuildContext context, TextEditingController controller) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add New Task"),
            content: TextField(
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: controller,
              decoration: InputDecoration(hintText: "Title"),
            ),
            actions: [
              TextButton(
                style: flatButtonStyle,
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => setState(() {
                  toDoTitle = valueText;
                  controller.clear();
                  Navigator.pop(context);
                }),
              )
            ],
          );
        });
  }

  void addToDoItems(ToDoItemData toDoItemData) async {
    await MyDB.inserToDoItem(toDoItemData.toCompanion(true));
  }

  void updateScreen() {
    List<ToDoItemData> temp = [];
    MyDB.getAllToDoItems().then((databaselist) {
      for (var toDoItem in databaselist) {
        temp.add(toDoItem);
      }
      setState(() {
        ToDoItemList = temp;
      });
    });
  }
}
