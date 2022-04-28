import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;

part 'database.g.dart';

class ToDoItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 80)();
  TextColumn get description => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  DateTimeColumn get deadline => dateTime()();
  BoolColumn get isDone => boolean()();
}

@DriftDatabase(tables: [ToDoItem])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFold = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFold.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
