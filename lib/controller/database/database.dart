import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
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
  Future<int> insertTodoItem(ToDoItemCompanion ToDoItem) async {
    return await into(toDoItem).insert(ToDoItem);
  }

  // Get a specific task
  Future<ToDoItemData> getToDoItem(int toDoId) async {
    return await (select(toDoItem)
          ..where((toDoItemTbl) => toDoItemTbl.id.equals(toDoId)))
        .getSingle();
  }

  // Update task
  Future<bool> updateToDoItem(ToDoItemCompanion ToDoItem) async {
    return await (update(toDoItem).replace(ToDoItem));
  }

  // Delete task
  Future<int> deleteToDoItem(ToDoItemCompanion ToDoItem) async {
    return await delete(toDoItem).delete(ToDoItem);
  }

  // Mark task as done
  Future<bool> markDoneToDoItem(ToDoItemCompanion ToDoItem) async {
    return await (update(toDoItem).replace(ToDoItem));
  }

  // Get all tasks

  Future<List<ToDoItemData>> getAllToDoItems() async {
    return await select(toDoItem).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFold = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFold.path, 'db.sqlite1'));
    return NativeDatabase(file);
  });
}
