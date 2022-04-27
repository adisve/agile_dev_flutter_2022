// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ToDoItemData extends DataClass implements Insertable<ToDoItemData> {
  final int id;
  final String title;
  final String? description;
  final int priority;
  final DateTime deadline;
  final bool isDone;
  ToDoItemData(
      {required this.id,
      required this.title,
      this.description,
      required this.priority,
      required this.deadline,
      required this.isDone});
  factory ToDoItemData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ToDoItemData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      priority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}priority'])!,
      deadline: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline'])!,
      isDone: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_done'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    map['priority'] = Variable<int>(priority);
    map['deadline'] = Variable<DateTime>(deadline);
    map['is_done'] = Variable<bool>(isDone);
    return map;
  }

  ToDoItemCompanion toCompanion(bool nullToAbsent) {
    return ToDoItemCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priority: Value(priority),
      deadline: Value(deadline),
      isDone: Value(isDone),
    );
  }

  factory ToDoItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToDoItemData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'priority': serializer.toJson<int>(priority),
      'deadline': serializer.toJson<DateTime>(deadline),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  ToDoItemData copyWith(
          {int? id,
          String? title,
          String? description,
          int? priority,
          DateTime? deadline,
          bool? isDone}) =>
      ToDoItemData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        deadline: deadline ?? this.deadline,
        isDone: isDone ?? this.isDone,
      );
  @override
  String toString() {
    return (StringBuffer('ToDoItemData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('deadline: $deadline, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, priority, deadline, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToDoItemData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.priority == this.priority &&
          other.deadline == this.deadline &&
          other.isDone == this.isDone);
}

class ToDoItemCompanion extends UpdateCompanion<ToDoItemData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> priority;
  final Value<DateTime> deadline;
  final Value<bool> isDone;
  const ToDoItemCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.deadline = const Value.absent(),
    this.isDone = const Value.absent(),
  });
  ToDoItemCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    required DateTime deadline,
    required bool isDone,
  })  : title = Value(title),
        deadline = Value(deadline),
        isDone = Value(isDone);
  static Insertable<ToDoItemData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? description,
    Expression<int>? priority,
    Expression<DateTime>? deadline,
    Expression<bool>? isDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (deadline != null) 'deadline': deadline,
      if (isDone != null) 'is_done': isDone,
    });
  }

  ToDoItemCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int>? priority,
      Value<DateTime>? deadline,
      Value<bool>? isDone}) {
    return ToDoItemCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToDoItemCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('deadline: $deadline, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }
}

class $ToDoItemTable extends ToDoItem
    with TableInfo<$ToDoItemTable, ToDoItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToDoItemTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int?> priority = GeneratedColumn<int?>(
      'priority', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime?> deadline = GeneratedColumn<DateTime?>(
      'deadline', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool?> isDone = GeneratedColumn<bool?>(
      'is_done', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_done IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, priority, deadline, isDone];
  @override
  String get aliasedName => _alias ?? 'to_do_item';
  @override
  String get actualTableName => 'to_do_item';
  @override
  VerificationContext validateIntegrity(Insertable<ToDoItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    } else if (isInserting) {
      context.missing(_isDoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ToDoItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ToDoItemData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ToDoItemTable createAlias(String alias) {
    return $ToDoItemTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ToDoItemTable toDoItem = $ToDoItemTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [toDoItem];
}
