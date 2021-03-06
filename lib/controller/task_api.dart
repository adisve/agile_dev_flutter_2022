import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:intl/intl.dart';

List<TodoModel> batchDelete(List<TodoModel> todoItemList) {
  List<TodoModel> toRemove = [];
  for (var item in todoItemList) {
    if (item.isChecked) {
      locator<MyDatabase>().moveTodoItem(ToDoItemData(
              id: item.id,
              title: item.title,
              description: item.description,
              createdDate: item.createdDate,
              isDone: false,
              priority: item.priority)
          .toCompanion(true));
      toRemove.add(item);
      locator<MyDatabase>().deleteToDoItem(ToDoItemData(
              id: item.id,
              title: item.title,
              description: item.description,
              createdDate: item.createdDate,
              isDone: false,
              priority: item.priority)
          .toCompanion(true));
    }
  }
  return toRemove;
}

List<TodoModel> batchFinish(List<TodoModel> todoItemList) {
  List<TodoModel> toFinish = [];
  for (var item in todoItemList) {
    if (item.isChecked) {
      locator<MyDatabase>().moveTodoItem(ToDoItemData(
              id: item.id,
              title: item.title,
              description: item.description,
              createdDate: item.createdDate,
              isDone: true,
              priority: item.priority)
          .toCompanion(true));
      toFinish.add(item);
      locator<MyDatabase>().deleteToDoItem(ToDoItemData(
              id: item.id,
              title: item.title,
              description: item.description,
              createdDate: item.createdDate,
              isDone: false,
              priority: item.priority)
          .toCompanion(true));
    }
  }
  return toFinish;
}

Future<ToDoItemData> getToDoItem(int toDoId) async {
  return await locator<MyDatabase>().getToDoItem(toDoId);
}

Future<List<TodoModel>> getTodoItemsFromDb() async {
  List<TodoModel> temp = [];
  locator<MyDatabase>().getAllToDoItems().then((databaselist) {
    databaselist.sort((a, b) => a.priority!.compareTo(b.priority!));
    for (var toDoItem in databaselist) {
      temp.add(TodoModel(toDoItem.id, toDoItem.title, toDoItem.description,
          toDoItem.priority, toDoItem.createdDate, toDoItem.isDone, false));
    }
  });
  return temp;
}

Future<List<StashedTaskData>> getAllStashedTasks() async {
  return await locator<MyDatabase>().getAllStashedTaskItems();
}

Future<List<MentalStateReportData>> getAllMentalStateReports() async {
  return await locator<MyDatabase>().getAllMentalStateReports();
}

void deleteStashedTask(StashedTaskData stashedTaskData) async {
  await locator<MyDatabase>()
      .deleteStashedTask(stashedTaskData.toCompanion(true));
}

void addToDoItems(ToDoItemData toDoItemData) async {
  await locator<MyDatabase>().insertTodoItem(toDoItemData.toCompanion(true));
}

void deleteMentalStateReport(
    MentalStateReportData mentalStateReportData) async {
  await locator<MyDatabase>()
      .deleteMentalStateReport(mentalStateReportData.toCompanion(true));
}

void addMentalStateReport(MentalStateReportData mentalStateReportData) async {
  List<MentalStateReportData> mentalStateReports =
      await getAllMentalStateReports();

  final reports = mentalStateReports.where((element) =>
      DateFormat('yyyy.MM.dd').format(DateTime.parse(element.createdDate!)) ==
      DateFormat('yyyy.MM.dd')
          .format(DateTime.parse(mentalStateReportData.createdDate!)));

  // If there is any report for the same day already => delete the row
  if (reports.isNotEmpty) {
    for (var item in reports) {
      await locator<MyDatabase>()
          .deleteMentalStateReport(item.toCompanion(true));
    }
  }
  //Add the new row
  await locator<MyDatabase>()
      .instertMentalStateReport(mentalStateReportData.toCompanion(true));
}

Future<bool> isPopupAnswered() async {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  return await locator<MyDatabase>()
          .getPossibleMentalState(date.toIso8601String()) !=
      null;
}
