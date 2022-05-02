import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';

List<TodoModel> batchDelete(List<TodoModel> todoItemList) {
  List<TodoModel> toRemove = [];
  for (var item in todoItemList) {
    if (item.isChecked) {
      locator<MyDatabase>().deleteToDoItem(ToDoItemData(
              id: item.id,
              title: item.title,
              description: item.description,
              deadline: item.deadline,
              isDone: item.isDone,
              priority: item.priority)
          .toCompanion(true));
      toRemove.add(item);
    }
  }
  return toRemove;
}

Future<ToDoItemData> getToDoItem(int toDoId) async {
  return await locator<MyDatabase>().getToDoItem(toDoId);
}

Future<List<TodoModel>> getTodoItemsFromDb() async {
  List<TodoModel> temp = [];
  locator<MyDatabase>().getAllToDoItems().then((databaselist) {
    for (var toDoItem in databaselist) {
      temp.add(TodoModel(toDoItem.id, toDoItem.title, toDoItem.description,
          toDoItem.priority, toDoItem.deadline, toDoItem.isDone, false));
    }
  });
  return temp;
}

void addToDoItems(ToDoItemData toDoItemData) async {
  await locator<MyDatabase>().inserToDoItem(toDoItemData.toCompanion(true));
}
