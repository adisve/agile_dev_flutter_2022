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

  String descriptionValueText = "";
  String titleValueText = "";
  String toDoTitle = "";
  String toDoDescription = "";
  int toDoPriority = 2;

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
                          createTask(context, titleController);
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

    int taskPriority;
    if (todoModel.priority != null) {
      taskPriority = todoModel.priority!;
    } else {
      taskPriority = 2;
    }

    String dropdownvalue = taskPriority.toString();

    // List of items in our dropdown menu
    var items = ['1', '2', '3'];

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
              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {                    
                    dropdownvalue = newValue!;
                  });
                },
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
                    toDoPriority = int.parse(dropdownvalue);
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
      titleValueText = "";
    });
    updateScreen();
  }

  void editTaskParent(TodoModel todoModel) async {
    await showEditDescription(context, titleController, todoModel);
    if (toDoDescription == "" && toDoTitle == "") return;
    ToDoItemData itemToEdit =
        await locator<MyDatabase>().getToDoItem(todoModel.id);

    locator<MyDatabase>().updateToDoItem(ToDoItemData(
            id: itemToEdit.id,
            title: toDoTitle == "" ? itemToEdit.title : toDoTitle,
            description: toDoDescription == ""
                ? itemToEdit.description
                : toDoDescription,
            priority: itemToEdit.priority,
            deadline: itemToEdit.deadline,
            isDone: itemToEdit.isDone)
        .toCompanion(true));

    setState(() {
      toDoDescription = "";
      toDoTitle = "";
      titleValueText = "";
      descriptionValueText = "";
    });
    updateScreen();
  }
}
