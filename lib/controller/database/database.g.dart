// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ToDoItemData extends DataClass implements Insertable<ToDoItemData> {
  final int id;
  final String title;
  final String? description;
  final int? priority;
  final String? createdDate;
  final bool? isDone;
  ToDoItemData(
      {required this.id,
      required this.title,
      this.description,
      this.priority,
      this.createdDate,
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
      createdDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdDate']),
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
    if (!nullToAbsent || createdDate != null) {
      map['createdDate'] = Variable<String?>(createdDate);
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
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
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
      createdDate: serializer.fromJson<String?>(json['createdDate']),
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
      'createdDate': serializer.toJson<String?>(createdDate),
      'isDone': serializer.toJson<bool?>(isDone),
    };
  }

  ToDoItemData copyWith(
          {int? id,
          String? title,
          String? description,
          int? priority,
          String? createdDate,
          bool? isDone}) =>
      ToDoItemData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        createdDate: createdDate ?? this.createdDate,
        isDone: isDone ?? this.isDone,
      );
  @override
  String toString() {
    return (StringBuffer('ToDoItemData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('createdDate: $createdDate, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, priority, createdDate, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToDoItemData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.priority == this.priority &&
          other.createdDate == this.createdDate &&
          other.isDone == this.isDone);
}

class ToDoItemCompanion extends UpdateCompanion<ToDoItemData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int?> priority;
  final Value<String?> createdDate;
  final Value<bool?> isDone;
  const ToDoItemCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.isDone = const Value.absent(),
  });
  ToDoItemCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.isDone = const Value.absent(),
  }) : title = Value(title);
  static Insertable<ToDoItemData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? description,
    Expression<int?>? priority,
    Expression<String?>? createdDate,
    Expression<bool?>? isDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (createdDate != null) 'createdDate': createdDate,
      if (isDone != null) 'isDone': isDone,
    });
  }

  ToDoItemCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int?>? priority,
      Value<String?>? createdDate,
      Value<bool?>? isDone}) {
    return ToDoItemCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      createdDate: createdDate ?? this.createdDate,
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
    if (createdDate.present) {
      map['createdDate'] = Variable<String?>(createdDate.value);
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
          ..write('createdDate: $createdDate, ')
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
  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  late final GeneratedColumn<String?> createdDate = GeneratedColumn<String?>(
      'createdDate', aliasedName, true,
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
      [id, title, description, priority, createdDate, isDone];
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
    if (data.containsKey('createdDate')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['createdDate']!, _createdDateMeta));
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

class StashedTaskData extends DataClass implements Insertable<StashedTaskData> {
  final String? createdDate;
  final bool? isDone;
  final int id;
  StashedTaskData({this.createdDate, this.isDone, required this.id});
  factory StashedTaskData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StashedTaskData(
      createdDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdDate']),
      isDone: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}isDone']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdDate != null) {
      map['createdDate'] = Variable<String?>(createdDate);
    }
    if (!nullToAbsent || isDone != null) {
      map['isDone'] = Variable<bool?>(isDone);
    }
    map['id'] = Variable<int>(id);
    return map;
  }

  StashedTaskCompanion toCompanion(bool nullToAbsent) {
    return StashedTaskCompanion(
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      id: Value(id),
    );
  }

  factory StashedTaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StashedTaskData(
      createdDate: serializer.fromJson<String?>(json['createdDate']),
      isDone: serializer.fromJson<bool?>(json['isDone']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdDate': serializer.toJson<String?>(createdDate),
      'isDone': serializer.toJson<bool?>(isDone),
      'id': serializer.toJson<int>(id),
    };
  }

  StashedTaskData copyWith({String? createdDate, bool? isDone, int? id}) =>
      StashedTaskData(
        createdDate: createdDate ?? this.createdDate,
        isDone: isDone ?? this.isDone,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('StashedTaskData(')
          ..write('createdDate: $createdDate, ')
          ..write('isDone: $isDone, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdDate, isDone, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StashedTaskData &&
          other.createdDate == this.createdDate &&
          other.isDone == this.isDone &&
          other.id == this.id);
}

class StashedTaskCompanion extends UpdateCompanion<StashedTaskData> {
  final Value<String?> createdDate;
  final Value<bool?> isDone;
  final Value<int> id;
  const StashedTaskCompanion({
    this.createdDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.id = const Value.absent(),
  });
  StashedTaskCompanion.insert({
    this.createdDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.id = const Value.absent(),
  });
  static Insertable<StashedTaskData> custom({
    Expression<String?>? createdDate,
    Expression<bool?>? isDone,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (createdDate != null) 'createdDate': createdDate,
      if (isDone != null) 'isDone': isDone,
      if (id != null) 'id': id,
    });
  }

  StashedTaskCompanion copyWith(
      {Value<String?>? createdDate, Value<bool?>? isDone, Value<int>? id}) {
    return StashedTaskCompanion(
      createdDate: createdDate ?? this.createdDate,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdDate.present) {
      map['createdDate'] = Variable<String?>(createdDate.value);
    }
    if (isDone.present) {
      map['isDone'] = Variable<bool?>(isDone.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StashedTaskCompanion(')
          ..write('createdDate: $createdDate, ')
          ..write('isDone: $isDone, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class StashedTask extends Table with TableInfo<StashedTask, StashedTaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  StashedTask(this.attachedDatabase, [this._alias]);
  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  late final GeneratedColumn<String?> createdDate = GeneratedColumn<String?>(
      'createdDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  late final GeneratedColumn<bool?> isDone = GeneratedColumn<bool?>(
      'isDone', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY');
  @override
  List<GeneratedColumn> get $columns => [createdDate, isDone, id];
  @override
  String get aliasedName => _alias ?? 'StashedTask';
  @override
  String get actualTableName => 'StashedTask';
  @override
  VerificationContext validateIntegrity(Insertable<StashedTaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('createdDate')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['createdDate']!, _createdDateMeta));
    }
    if (data.containsKey('isDone')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['isDone']!, _isDoneMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StashedTaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StashedTaskData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  StashedTask createAlias(String alias) {
    return StashedTask(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MentalStateReportData extends DataClass
    implements Insertable<MentalStateReportData> {
  final String? createdDate;
  final int? value;
  final int id;
  MentalStateReportData({this.createdDate, this.value, required this.id});
  factory MentalStateReportData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MentalStateReportData(
      createdDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdDate']),
      value: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdDate != null) {
      map['createdDate'] = Variable<String?>(createdDate);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<int?>(value);
    }
    map['id'] = Variable<int>(id);
    return map;
  }

  MentalStateReportCompanion toCompanion(bool nullToAbsent) {
    return MentalStateReportCompanion(
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      id: Value(id),
    );
  }

  factory MentalStateReportData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MentalStateReportData(
      createdDate: serializer.fromJson<String?>(json['createdDate']),
      value: serializer.fromJson<int?>(json['value']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdDate': serializer.toJson<String?>(createdDate),
      'value': serializer.toJson<int?>(value),
      'id': serializer.toJson<int>(id),
    };
  }

  MentalStateReportData copyWith({String? createdDate, int? value, int? id}) =>
      MentalStateReportData(
        createdDate: createdDate ?? this.createdDate,
        value: value ?? this.value,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('MentalStateReportData(')
          ..write('createdDate: $createdDate, ')
          ..write('value: $value, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdDate, value, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MentalStateReportData &&
          other.createdDate == this.createdDate &&
          other.value == this.value &&
          other.id == this.id);
}

class MentalStateReportCompanion
    extends UpdateCompanion<MentalStateReportData> {
  final Value<String?> createdDate;
  final Value<int?> value;
  final Value<int> id;
  const MentalStateReportCompanion({
    this.createdDate = const Value.absent(),
    this.value = const Value.absent(),
    this.id = const Value.absent(),
  });
  MentalStateReportCompanion.insert({
    this.createdDate = const Value.absent(),
    this.value = const Value.absent(),
    this.id = const Value.absent(),
  });
  static Insertable<MentalStateReportData> custom({
    Expression<String?>? createdDate,
    Expression<int?>? value,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (createdDate != null) 'createdDate': createdDate,
      if (value != null) 'value': value,
      if (id != null) 'id': id,
    });
  }

  MentalStateReportCompanion copyWith(
      {Value<String?>? createdDate, Value<int?>? value, Value<int>? id}) {
    return MentalStateReportCompanion(
      createdDate: createdDate ?? this.createdDate,
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdDate.present) {
      map['createdDate'] = Variable<String?>(createdDate.value);
    }
    if (value.present) {
      map['value'] = Variable<int?>(value.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MentalStateReportCompanion(')
          ..write('createdDate: $createdDate, ')
          ..write('value: $value, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class MentalStateReport extends Table
    with TableInfo<MentalStateReport, MentalStateReportData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MentalStateReport(this.attachedDatabase, [this._alias]);
  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  late final GeneratedColumn<String?> createdDate = GeneratedColumn<String?>(
      'createdDate', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<int?> value = GeneratedColumn<int?>(
      'value', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY');
  @override
  List<GeneratedColumn> get $columns => [createdDate, value, id];
  @override
  String get aliasedName => _alias ?? 'MentalStateReport';
  @override
  String get actualTableName => 'MentalStateReport';
  @override
  VerificationContext validateIntegrity(
      Insertable<MentalStateReportData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('createdDate')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['createdDate']!, _createdDateMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MentalStateReportData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MentalStateReportData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  MentalStateReport createAlias(String alias) {
    return MentalStateReport(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final ToDoItem toDoItem = ToDoItem(this);
  late final StashedTask stashedTask = StashedTask(this);
  late final MentalStateReport mentalStateReport = MentalStateReport(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [toDoItem, stashedTask, mentalStateReport];
}
