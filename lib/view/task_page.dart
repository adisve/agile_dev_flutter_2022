import 'dart:developer' as dev;
import 'dart:math';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:agile_dev_2022/view/task_card.dart';
import 'package:flutter/material.dart';
import 'package:agile_dev_2022/controller/database/database.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<TaskPage> createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<TaskPage> {
  List<TodoModel> checkedItemList = [];
  late List<bool> isChecked;
  late List<TodoModel> todoItemList = [];
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.all(8));
  String valueText = "";
  String toDoTitle = "";
  String toDoDescription = "";
  final controller = TextEditingController();

  @override
  void initState() {
    updateScreen();
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
                scrollDirection: Axis.vertical,
                itemCount: todoItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    TaskCard(
                      notifyParent: updateCheckedList,
                      toDoItem: todoItemList[index],
                      editTaskParent: editTaskParent,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 30, bottom: 40),
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
                  alignment: Alignment.bottomRight,
                  child: Container(
                      padding: EdgeInsets.only(right: 30, bottom: 40),
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
            )
          ],
        ));
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

  Future<void> showEditDescription(BuildContext context,
      TextEditingController controller, TodoModel todoModel) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add description for ${todoModel.title}"),
            content: TextField(
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: controller,
              decoration: InputDecoration(hintText: "Description"),
            ),
            actions: [
              TextButton(
                style: flatButtonStyle,
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    toDoDescription = valueText;
                  });
                  controller.clear();
                  dev.log(toDoDescription);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void updateScreen() {
    getTodoItemsFromDb().then((dbTodoItems) => setState(() {
          todoItemList = dbTodoItems;
        }));
  }

  void updateCheckedList(TodoModel todoModel) {
    if (checkedItemList.contains(todoModel)) {
      setState(() {
        checkedItemList.remove(todoModel);
      });
      return;
    }
    setState(() {
      checkedItemList.add(todoModel);
    });
  }

  void removeCheckedList() async {
    List<TodoModel> toRemove = batchDelete(todoItemList);
    setState(() {
      todoItemList.removeWhere((todo) => toRemove.contains(todo));
    });
  }

  void createTask(
      BuildContext context, TextEditingController controller) async {
    await showCreateToDoItem(context, controller);
    if (toDoTitle == "") {
      return;
    }
    addToDoItems(
        ToDoItemData(id: Random.secure().nextInt(123456), title: toDoTitle));
    setState(() {
      toDoTitle = "";
    });
    updateScreen();
  }

  void editTaskParent(TodoModel todoModel) async {
    await showEditDescription(context, controller, todoModel);
    if (toDoDescription == "") return;
    ToDoItemData itemToEdit =
        await locator<MyDatabase>().getToDoItem(todoModel.id);
    locator<MyDatabase>().updateToDoItem(ToDoItemData(
            id: itemToEdit.id,
            title: itemToEdit.title,
            description: toDoDescription,
            priority: itemToEdit.priority,
            deadline: itemToEdit.deadline,
            isDone: itemToEdit.isDone)
        .toCompanion(true));

    setState(() {
      toDoDescription = "";
    });
    updateScreen();
  }
}
