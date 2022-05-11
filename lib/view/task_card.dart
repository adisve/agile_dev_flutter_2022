import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

class TaskCard extends StatefulWidget {
  final Function notifyParent;
  final Function editTaskParent;
  final TodoModel toDoItem;

  @override
  State<TaskCard> createState() => _TaskCardState();

  TaskCard(
      {Key? key,
      required this.notifyParent,
      required this.toDoItem,
      required this.editTaskParent})
      : super(key: key);
}

class _TaskCardState extends State<TaskCard> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.green,
      textStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.all(8));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
              color: Color.fromARGB(255, 173, 206, 233),
              elevation: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Checkbox(
                                fillColor: () {
                                  if (widget.toDoItem.priority == 1) {
                                    return MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 164, 45, 65));
                                  } else if (widget.toDoItem.priority == 2) {
                                    return MaterialStateProperty.all<Color>(
                                        Colors.amber);
                                  } else if (widget.toDoItem.priority == 3) {
                                    return MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 67, 175, 205));
                                  }
                                }(),
                                key: UniqueKey(),
                                shape: CircleBorder(),
                                value: widget.toDoItem.isChecked,
                                onChanged: (newValue) {
                                  widget.notifyParent(widget.toDoItem);
                                  setState(() {
                                    widget.toDoItem.isChecked = newValue!;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                              ),
                              child: Text(
                                widget.toDoItem.title.length < 35
                                    ? widget.toDoItem.title
                                    : widget.toDoItem.title.substring(0, 35) +
                                        "...",
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            )
                          ]),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.toDoItem.description != null)
                            () {
                              return Padding(
                                padding: const EdgeInsets.only(left: 52),
                                child: Text(
                                  widget.toDoItem.description!,
                                  style: const TextStyle(
                                      color: Color(0xFF434343), fontSize: 17),
                                ),
                              );
                            }(),
                        ]),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 30, bottom: 40),
                        child: NiceButtons(
                          endColor: Color.fromARGB(255, 67, 175, 205),
                          borderColor: Color.fromARGB(255, 67, 175, 205),
                          startColor: Color.fromARGB(255, 67, 175, 205),
                          width: 60,
                          height: 40,
                          stretch: false,
                          onTap: (finish) {
                            widget.editTaskParent(widget.toDoItem);
                          },
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
