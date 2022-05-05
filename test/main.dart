import 'dart:math';
import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/model/todo_model.dart';
import 'package:agile_dev_2022/view/task_page.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  locator.registerSingleton<MyDatabase>(MyDatabase());

  /// Group [MyDatabase] functions for testing
  group('Testing database functionality ', () {
    test('Test POST request', () async {
      int id = Random.secure().nextInt(12343);
      expect(
          await locator<MyDatabase>().insertTodoItem(
              ToDoItemData(id: id, title: "TEST").toCompanion(true)),
          id);

      // DELETE from database after test
      locator<MyDatabase>().deleteToDoItem(ToDoItemCompanion(id: Value(id)));
    });

    test('Test GET request', () async {
      int id = Random.secure().nextInt(12343);
      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: id, title: "TEST").toCompanion(true));
      expect(await locator<MyDatabase>().getToDoItem(id),
          ToDoItemData(id: id, title: "TEST", priority: 2));

      // DELETE from database after test
      locator<MyDatabase>().deleteToDoItem(ToDoItemCompanion(id: Value(id)));
    });

    test('Test DELETE request', () async {
      int id = Random.secure().nextInt(12343);
      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: id, title: "TEST").toCompanion(true));
      expect(
          await locator<MyDatabase>()
              .deleteToDoItem(ToDoItemCompanion(id: Value(id))),
          1);
    });
  });

  group('Group for testing some widgets', () {
    testWidgets('Test todocard', ((widgetTester) async {
      await widgetTester.pumpWidget(MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: TaskPage())));

      final titleFinder = find.text('Today');
      expect(titleFinder, findsOneWidget);
    }));
  });

  group('task_api testing', () {
    test('Testing getToDoItem', () async {
      int todoID = Random.secure().nextInt(12343);
      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: todoID, title: "Hello there").toCompanion(false));

      expect(await getToDoItem(todoID),
          await locator<MyDatabase>().getToDoItem(todoID));

      locator<MyDatabase>()
          .deleteToDoItem(ToDoItemCompanion(id: Value(todoID)));
    });

    test('Testing getToDoItemsFromDB', () async {
      int id1 = Random.secure().nextInt(12343);
      int id2 = Random.secure().nextInt(12343);
      int id3 = Random.secure().nextInt(12343);

      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: id1, title: "Hello there").toCompanion(false));
      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: id2, title: "General Kenobi...").toCompanion(false));
      await locator<MyDatabase>().insertTodoItem(
          ToDoItemData(id: id3, title: "You are a bold one")
              .toCompanion(false));

      List todoList = [];
      List<TodoModel> testModelList = [];
      todoList.add(await locator<MyDatabase>().getToDoItem(id1));
      todoList.add(await locator<MyDatabase>().getToDoItem(id2));
      todoList.add(await locator<MyDatabase>().getToDoItem(id3));
      for (var toDoItem in todoList) {
        testModelList.add(TodoModel(
            toDoItem.id,
            toDoItem.title,
            toDoItem.description,
            toDoItem.priority,
            toDoItem.deadline,
            toDoItem.isDone,
            false));
      }
      expect(await getTodoItemsFromDb(), equals(todoList));
    });

    test('Testing addToDoItems', () async {
      int todoID = Random.secure().nextInt(12343);
      addToDoItems(
          ToDoItemData(id: todoID, title: "Do or do not, there is no try"));

      expect(await getToDoItem(todoID),
          await locator<MyDatabase>().getToDoItem(todoID));

      locator<MyDatabase>()
          .deleteToDoItem(ToDoItemCompanion(id: Value(todoID)));
    });
  });
}
