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

  Future<int> moveTodoItem(ToDoItemCompanion toDoItemCompanion) async {
    return await insertStashedTask(StashedTaskCompanion(
        createdDate: toDoItemCompanion.createdDate,
        isDone: toDoItemCompanion.isDone,
        id: toDoItemCompanion.id));
  }

  // Mark task as done
  Future<bool> markDoneToDoItem(ToDoItemCompanion ToDoItem) async {
    return await (update(toDoItem).replace(ToDoItem));
  }

  // Get all tasks
  Future<List<ToDoItemData>> getAllToDoItems() async {
    return await select(toDoItem).get();
  }

  Future<List<StashedTaskData>> getAllStashedTaskItems() async {
    return await select(stashedTask).get();
  }

  Future<int> insertStashedTask(
      StashedTaskCompanion stashedTaskCompanion) async {
    return await into(stashedTask).insert(stashedTaskCompanion);
  }

  Future<int> deleteStashedTask(
      StashedTaskCompanion stashedTaskCompanion) async {
    return await delete(stashedTask).delete(stashedTaskCompanion);
  }

  // Get all mental state reports
  Future<List<MentalStateReportData>> getAllMentalStateReports() async {
    return await select(mentalStateReport).get();
  }

  // Add a mental state report
  Future<int> instertMentalStateReport(
      MentalStateReportCompanion mentalStateReportCompanion) async {
    return await into(mentalStateReport).insert(mentalStateReportCompanion);
  }

  // Delete a mental state report
  Future<int> deleteMentalStateReport(
      MentalStateReportCompanion mentalStateReportCompanion) async {
    return await delete(mentalStateReport).delete(mentalStateReportCompanion);
  }

  //Replace
  Future<bool> updateMentalStateReport(
      MentalStateReportCompanion mentalStateReportCompanion) async {
    return await (update(mentalStateReport)
        .replace(mentalStateReportCompanion));
  }

  Future<MentalStateReportData?> getPossibleMentalState(String date) async {
    return await (select(mentalStateReport)
          ..where((toDoItemTbl) => toDoItemTbl.createdDate.equals(date)))
        .getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFold = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFold.path, 'db.sqlite8'));
    return NativeDatabase(file);
  });
}
