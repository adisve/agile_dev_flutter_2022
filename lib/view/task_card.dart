import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';

class TaskCard extends StatefulWidget {
  final Function notifyParent;
  final Function editTaskParent;
  final TodoModel toDoItem;
  final bool rescheduleTask;

  @override
  State<TaskCard> createState() => _TaskCardState();

  TaskCard({
    Key? key,
    required this.notifyParent,
    required this.toDoItem,
    required this.editTaskParent,
    required this.rescheduleTask,
  }) : super(key: key);
}

class _TaskCardState extends State<TaskCard> {
  // add check if overdue method
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
              elevation: 0,
              color: checkOverdue(widget.toDoItem)
                  ? Colors.yellow[200]
                  : Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 13,
                                ),
                                child: Text(
                                  widget.toDoItem.title.length < 35
                                      ? widget.toDoItem.title
                                      : widget.toDoItem.title.substring(0, 35) +
                                          "...",
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.roboto(fontSize: 22),
                                ),
                              ),
                            )
                          ]),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 52, bottom: 50),
                              child: Text(
                                widget.toDoItem.description == null
                                    ? ""
                                    : widget.toDoItem.description!,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.roboto(fontSize: 17),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                flex: 0,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(right: 30, bottom: 20),
                                  child: IconButton(
                                    splashRadius: 30,
                                    color: Color.fromRGBO(33, 34, 39, 1.0),
                                    onPressed: () {
                                      widget.editTaskParent(widget.toDoItem);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Color.fromRGBO(33, 34, 39, 1.0)),
                                  ),
                                ),
                              ),
                              if (checkOverdue(widget.toDoItem))
                                Container(child: getRescheduleButton())
                            ],
                          )
                        ])
                  ])),
        ));
  }

  bool checkOverdue(TodoModel toDoItem) {
    if (DateTime.parse(toDoItem.createdDate.toString())
            .difference(DateTime.now())
            .inDays >=
        0) {
      return true;
    }
    return false;
  }

  Widget getRescheduleButton() {
    return Container(
        padding: EdgeInsets.only(right: 30, bottom: 20),
        child: IconButton(
            splashRadius: 20,
            color: Color.fromRGBO(33, 34, 39, 1.0),
            onPressed: () {
              // insert reschedule code here
            },
            icon: Icon(Icons.edit_calendar,
                color: Color.fromRGBO(33, 34, 39, 1.0))));
  }
}
