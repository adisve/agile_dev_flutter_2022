import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Create a task
  Future<int> inserToDoItem(ToDoItemCompanion ToDoItem) async {
    return await into(toDoItem).insert(ToDoItem);
  }

  // Get a specific task
  Future<ToDoItemData> getToDoItem(int toDoId) async {
    return await (select(toDoItem)
          ..where((toDoItemTbl) => toDoItemTbl.id.equals(toDoId)))
        .getSingle();
  }

  // Update task

  // Delete task

  // Mark task as done

  // Get all tasks

  Future<List<ToDoItemData>> getAllToDoItems() async {
    return await select(toDoItem).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFold = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFold.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

/*
""" CREATE TABLE IF NOT EXISTS
    ToDo_item(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Title VARCHAR(80) NOT NULL,
        Description TEXT,
        Priority INTEGER DEFAULT 2 NOT NULL,
        Deadline TEXT NOT NULL,
        isDone BOOLEAN NOT NULL CHECK (isDone IN (0, 1))
    )
    """
*/