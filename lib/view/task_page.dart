import 'dart:developer' as dev;
import 'dart:math';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:agile_dev_2022/view/task_card.dart';
import 'package:flutter/material.dart';
import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:nice_buttons/nice_buttons.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

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

  String descriptionValueText = "";
  String titleValueText = "";
  String priorityValueText = "";

  String toDoTitle = "";
  String toDoDescription = "";
  int toDoPriority = 0;

  final priorityController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
              padding: EdgeInsets.only(top: 50, left: 35),
              alignment: Alignment.topLeft,
              child: const Text(
                "Today",
                style: TextStyle(
                    fontSize: 40, color: Color.fromRGBO(33, 34, 39, 1.0)),
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 30, bottom: 20),
                          child: NiceButtons(
                            endColor: Color.fromARGB(255, 164, 45, 65),
                            borderColor: Color.fromARGB(255, 164, 45, 65),
                            startColor: Color.fromARGB(255, 164, 45, 65),
                            width: 60,
                            height: 40,
                            stretch: false,
                            onTap: (finish) {
                              removeCheckedList();
                            },
                            child:
                                Icon(Icons.remove_circle, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 30, bottom: 20),
                          child: NiceButtons(
                            endColor: Color.fromARGB(255, 45, 164, 83),
                            borderColor: Color.fromARGB(255, 45, 164, 83),
                            startColor: Color.fromARGB(255, 45, 164, 83),
                            width: 60,
                            height: 40,
                            stretch: false,
                            onTap: (finish) {
                              finishTasks();
                            },
                            child: Icon(Icons.done, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 30, bottom: 20),
                    child: NiceButtons(
                      endColor: Color.fromARGB(255, 67, 175, 205),
                      borderColor: Color.fromARGB(255, 67, 175, 205),
                      startColor: Color.fromARGB(255, 67, 175, 205),
                      width: 60,
                      height: 40,
                      stretch: false,
                      onTap: (finish) {
                        createTask(context, titleController);
                      },
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
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
                  titleValueText = value;
                });
              },
              controller: titleController,
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
                  toDoTitle = titleValueText;
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
    // Initial Selected Value

    priorityValueText =
        todoModel.priority != null ? todoModel.priority!.toString() : "2";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit information for ${todoModel.title}"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  setState(() {
                    titleValueText = value;
                  });
                },
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  setState(() {
                    descriptionValueText = value;
                  });
                },
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Description"),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 2),
                  child: Text("Priority:"),
                ),
              ),
              DropdownButtonFormField(
                // Initial Value
                value: priorityValueText,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: ['1', '2', '3'].map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onSaved: (String? newValue) => setState(() {
                  priorityValueText = newValue!;
                }),
                onChanged: (String? newValue) => setState(() {
                  priorityValueText = newValue!;
                }),
              ),
            ]),
            actions: [
              TextButton(
                style: flatButtonStyle,
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    toDoDescription = descriptionValueText;
                    toDoTitle = titleValueText;
                    toDoPriority = int.parse(priorityValueText);
                    descriptionController.clear();
                    titleController.clear();
                  });

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

  void createTask(
      BuildContext context, TextEditingController controller) async {
    await showCreateToDoItem(context, controller);
    if (toDoTitle == "") {
      return;
    }
    addToDoItems(ToDoItemData(
        id: Random.secure().nextInt(123456),
        title: toDoTitle,
        createdDate: DateTime.now().toIso8601String()));
    setState(() {
      toDoTitle = "";
      titleValueText = "";
    });
    updateScreen();
  }

  void editTaskParent(TodoModel todoModel) async {
    await showEditDescription(context, titleController, todoModel);
    if (toDoDescription == "" && toDoTitle == "" && toDoPriority == 0) return;
    ToDoItemData itemToEdit =
        await locator<MyDatabase>().getToDoItem(todoModel.id);

    locator<MyDatabase>().updateToDoItem(ToDoItemData(
            id: itemToEdit.id,
            title: toDoTitle == "" ? itemToEdit.title : toDoTitle,
            description: toDoDescription == ""
                ? itemToEdit.description
                : toDoDescription,
            priority: toDoPriority == 0 ? itemToEdit.priority : toDoPriority,
            createdDate: itemToEdit.createdDate,
            isDone: itemToEdit.isDone)
        .toCompanion(true));

    setState(() {
      toDoDescription = "";
      toDoTitle = "";
      toDoPriority = 0;
      titleValueText = "";
      descriptionValueText = "";
      priorityValueText = "";
    });
    updateScreen();
  }

  void removeCheckedList() async {
    List<TodoModel> toRemove = batchDelete(todoItemList);
    setState(() {
      todoItemList.removeWhere((todo) => toRemove.contains(todo));
    });
  }

  void finishTasks() {
    List<TodoModel> toFinish = batchFinish(todoItemList);
    setState(() {
      todoItemList.removeWhere((todo) => toFinish.contains(todo));
    });
  }
}
