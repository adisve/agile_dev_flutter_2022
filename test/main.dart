import 'dart:math';
import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/main.dart';
import 'package:agile_dev_2022/view/task_page.dart';
import 'package:drift/drift.dart';
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
}
