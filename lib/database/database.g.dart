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
  final int? priority;
  final String? deadline;
  final bool? isDone;
  ToDoItemData(
      {required this.id,
      required this.title,
      this.description,
      this.priority,
      this.deadline,
      this.isDone});
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
          .mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      deadline: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline']),
      isDone: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}isDone']),
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
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int?>(priority);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<String?>(deadline);
    }
    if (!nullToAbsent || isDone != null) {
      map['isDone'] = Variable<bool?>(isDone);
    }
    return map;
  }

  ToDoItemCompanion toCompanion(bool nullToAbsent) {
    return ToDoItemCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
    );
  }

  factory ToDoItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToDoItemData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      priority: serializer.fromJson<int?>(json['priority']),
      deadline: serializer.fromJson<String?>(json['deadline']),
      isDone: serializer.fromJson<bool?>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'priority': serializer.toJson<int?>(priority),
      'deadline': serializer.toJson<String?>(deadline),
      'isDone': serializer.toJson<bool?>(isDone),
    };
  }

  ToDoItemData copyWith(
          {int? id,
          String? title,
          String? description,
          int? priority,
          String? deadline,
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
  final Value<int?> priority;
  final Value<String?> deadline;
  final Value<bool?> isDone;
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
    this.deadline = const Value.absent(),
    this.isDone = const Value.absent(),
  }) : title = Value(title);
  static Insertable<ToDoItemData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? description,
    Expression<int?>? priority,
    Expression<String?>? deadline,
    Expression<bool?>? isDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (deadline != null) 'deadline': deadline,
      if (isDone != null) 'isDone': isDone,
    });
  }

  ToDoItemCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int?>? priority,
      Value<String?>? deadline,
      Value<bool?>? isDone}) {
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
      map['priority'] = Variable<int?>(priority.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<String?>(deadline.value);
    }
    if (isDone.present) {
      map['isDone'] = Variable<bool?>(isDone.value);
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

class ToDoItem extends Table with TableInfo<ToDoItem, ToDoItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ToDoItem(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY NOT NULL');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  late final GeneratedColumn<int?> priority = GeneratedColumn<int?>(
      'priority', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT 2',
      defaultValue: const CustomExpression<int>('2'));
  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  late final GeneratedColumn<String?> deadline = GeneratedColumn<String?>(
      'deadline', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  late final GeneratedColumn<bool?> isDone = GeneratedColumn<bool?>(
      'isDone', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      $customConstraints: 'CHECK (isDone IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, priority, deadline, isDone];
  @override
  String get aliasedName => _alias ?? 'ToDoItem';
  @override
  String get actualTableName => 'ToDoItem';
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
    }
    if (data.containsKey('isDone')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['isDone']!, _isDoneMeta));
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
  ToDoItem createAlias(String alias) {
    return ToDoItem(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final ToDoItem toDoItem = ToDoItem(this);
  Future<int> insert_dummy_rows() {
    return customInsert(
      'INSERT INTO ToDoItem (title, description, priority, deadline, isDone)\r\n    VALUES \r\n    (\'Return book\', \'Library working hours - 8-20\', 3, DATE(\'now\'), 0),\r\n    (\'Read 50 p from students book\', \'The book is on Canvas\', 1, \'2016-08-01\', 0)',
      variables: [],
      updates: {toDoItem},
    );
  }

  Future<int> insert_more_dummies() {
    return customInsert(
      'INSERT INTO ToDoItem (title, description, deadline, isDone)\r\n    VALUES \r\n    (\'Do laundry\', NULL, DATE(\'now\'), 0)',
      variables: [],
      updates: {toDoItem},
    );
  }

  Future<int> add_task(String title, String? description, int? priority,
      String? deadline, bool? isDone) {
    return customInsert(
      'INSERT INTO ToDoItem (title, description, priority, deadline, isDone)\r\n    VALUES \r\n    (:title, :description, :priority, :deadline, :isDone)',
      variables: [
        Variable<String>(title),
        Variable<String?>(description),
        Variable<int?>(priority),
        Variable<String?>(deadline),
        Variable<bool?>(isDone)
      ],
      updates: {toDoItem},
    );
  }

  Future<int> delete_task(int id) {
    return customUpdate(
      'DELETE FROM ToDoItem WHERE id = :id',
      variables: [Variable<int>(id)],
      updates: {toDoItem},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> update_task(String title, String? description, int? priority,
      String? deadline, bool? isDone, int id) {
    return customUpdate(
      'UPDATE ToDoItem\r\n    SET title = :title, description = :description, priority = :priority, deadline = :deadline, isDone = :isDone\r\n    WHERE id = :id',
      variables: [
        Variable<String>(title),
        Variable<String?>(description),
        Variable<int?>(priority),
        Variable<String?>(deadline),
        Variable<bool?>(isDone),
        Variable<int>(id)
      ],
      updates: {toDoItem},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<ToDoItemData> fetch_tasks() {
    return customSelect('SELECT * FROM ToDoItem', variables: [], readsFrom: {
      toDoItem,
    }).map(toDoItem.mapFromRow);
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [toDoItem];
}
