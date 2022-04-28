import 'package:agile_dev_2022/database/database.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final Function notifyParent;
  final ToDoItemData toDoItem;

  @override
  State<TaskCard> createState() => _TaskCardState();

  const TaskCard({Key? key, required this.notifyParent, required this.toDoItem})
      : super(key: key);
}

class _TaskCardState extends State<TaskCard> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
              elevation: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Checkbox(
                              value: checked,
                              onChanged: (newValue) {
                                widget.notifyParent(widget.toDoItem);
                                setState(() {
                                  checked = newValue!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                            ),
                            child: Text(
                              widget.toDoItem.title,
                              maxLines: 1, // Don't wrap at all
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          )
                        ]),
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
                  ])),
        ));
  }
}
