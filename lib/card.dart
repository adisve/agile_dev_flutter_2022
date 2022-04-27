import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;

  const TaskCard({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 250,
      child: Card(
        elevation: 5,
        child: Text(
          title,
          style: const TextStyle(fontSize: 30, color: Colors.red),
        ),
        color: Colors.cyan,
      ),
    );
  }
}
