import 'dart:developer' as dev;
import 'dart:math';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:agile_dev_2022/view/task_card.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Color.fromRGBO(33, 34, 39, 1.0),
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
              child: Text(
                "Today",
                style: GoogleFonts.roboto(
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
                      rescheduleTask: true,
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
            CircularMenu(
              toggleButtonMargin: 20,
              toggleButtonSize: 30,
              toggleButtonIconColor: Color.fromARGB(255, 230, 230, 230),
              radius: 100,
              alignment: Alignment.bottomCenter,
              backgroundWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              curve: Curves.bounceOut,
              reverseCurve: Curves.bounceInOut,
              toggleButtonColor: Color.fromRGBO(33, 34, 39, 1.0),
              items: [
                CircularMenuItem(
                    margin: 20,
                    color: Color.fromRGBO(33, 34, 39, 1.0),
                    icon: Icons.add,
                    onTap: () => createTask(context, titleController)),
                CircularMenuItem(
                    margin: 20,
                    color: Color.fromRGBO(33, 34, 39, 1.0),
                    icon: Icons.remove,
                    onTap: () => removeCheckedList()),
                CircularMenuItem(
                  margin: 20,
                  color: Color.fromRGBO(33, 34, 39, 1.0),
                  icon: Icons.check,
                  onTap: () => finishTasks(),
                )
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
            title: Text(
              "Add New Task",
              style: GoogleFonts.roboto(
                  fontSize: 20, color: Color.fromRGBO(33, 34, 39, 1.0)),
            ),
            content: TextField(
              style: GoogleFonts.roboto(
                  fontSize: 15, color: Color.fromRGBO(33, 34, 39, 1.0)),
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
                  style: GoogleFonts.roboto(
                      fontSize: 15, color: Color.fromARGB(255, 240, 240, 240)),
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
            title: Text(
              "Edit information for ${todoModel.title}",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontSize: 20, color: Color.fromRGBO(33, 34, 39, 1.0)),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                style: GoogleFonts.roboto(
                    fontSize: 15, color: Color.fromRGBO(33, 34, 39, 1.0)),
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
                style: GoogleFonts.roboto(
                    fontSize: 15, color: Color.fromRGBO(33, 34, 39, 1.0)),
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
                  child: Text(
                    "Priority:",
                    style: GoogleFonts.roboto(
                        fontSize: 15, color: Color.fromRGBO(33, 34, 39, 1.0)),
                  ),
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
                  style: GoogleFonts.roboto(
                      fontSize: 15, color: Color.fromARGB(255, 240, 240, 240)),
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

  void rescheduleTaskParent(TodoModel toDoItem) async {
    setState(() {
      // insert code here
    });
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
