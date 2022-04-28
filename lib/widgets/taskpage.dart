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
  late List<ToDoItemData> ToDoItemList = [];
  final MyDB = MyDatabase();
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
        floatingActionButton: FloatingActionButton(
          onPressed:() => createTask(context, controller) ,
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

  void createTask(BuildContext context, TextEditingController controller) async {
    await showCreateToDoItem(context, controller);
    if(toDoTitle == ""){
      return;
    }
    addToDoItems(ToDoItemData(id: Random.secure().nextInt(1234), title: toDoTitle));
    setState(() {
      toDoTitle = "";
    });
    updateScreen();
  }

  Future<void> showCreateToDoItem(BuildContext context, TextEditingController controller) async {
    return showDialog(context: context, builder: (context)
    {return AlertDialog(
      title: Text(
        "Add New Task"),
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
          FlatButton(
            color: Color(0xff1282de),
             child: Text("Add"),
             textColor: Colors.white,
             onPressed:(){
               setState(() {
                 toDoTitle = valueText;
                 controller.clear();
                 Navigator.pop(context);
               });
             },
             )
        ],
        );
    });
  }

  void addToDoItems(ToDoItemData toDoItemData) async{
    await MyDB.inserToDoItem(toDoItemData.toCompanion(false));
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
    } );
  }




}
