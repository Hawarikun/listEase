// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateedAtMeta =
      const VerificationMeta('updateedAt');
  @override
  late final GeneratedColumn<DateTime> updateedAt = GeneratedColumn<DateTime>(
      'updateed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deleteddAtMeta =
      const VerificationMeta('deleteddAt');
  @override
  late final GeneratedColumn<DateTime> deleteddAt = GeneratedColumn<DateTime>(
      'deletedd_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryName, color, icon, createdAt, updateedAt, deleteddAt];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updateed_at')) {
      context.handle(
          _updateedAtMeta,
          updateedAt.isAcceptableOrUnknown(
              data['updateed_at']!, _updateedAtMeta));
    } else if (isInserting) {
      context.missing(_updateedAtMeta);
    }
    if (data.containsKey('deletedd_at')) {
      context.handle(
          _deleteddAtMeta,
          deleteddAt.isAcceptableOrUnknown(
              data['deletedd_at']!, _deleteddAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updateedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updateed_at'])!,
      deleteddAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deletedd_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String categoryName;
  final String color;
  final String icon;
  final DateTime createdAt;
  final DateTime updateedAt;
  final DateTime? deleteddAt;
  const Category(
      {required this.id,
      required this.categoryName,
      required this.color,
      required this.icon,
      required this.createdAt,
      required this.updateedAt,
      this.deleteddAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_name'] = Variable<String>(categoryName);
    map['color'] = Variable<String>(color);
    map['icon'] = Variable<String>(icon);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updateed_at'] = Variable<DateTime>(updateedAt);
    if (!nullToAbsent || deleteddAt != null) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      categoryName: Value(categoryName),
      color: Value(color),
      icon: Value(icon),
      createdAt: Value(createdAt),
      updateedAt: Value(updateedAt),
      deleteddAt: deleteddAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteddAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      color: serializer.fromJson<String>(json['color']),
      icon: serializer.fromJson<String>(json['icon']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateedAt: serializer.fromJson<DateTime>(json['updateedAt']),
      deleteddAt: serializer.fromJson<DateTime?>(json['deleteddAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
      'color': serializer.toJson<String>(color),
      'icon': serializer.toJson<String>(icon),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateedAt': serializer.toJson<DateTime>(updateedAt),
      'deleteddAt': serializer.toJson<DateTime?>(deleteddAt),
    };
  }

  Category copyWith(
          {int? id,
          String? categoryName,
          String? color,
          String? icon,
          DateTime? createdAt,
          DateTime? updateedAt,
          Value<DateTime?> deleteddAt = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
        updateedAt: updateedAt ?? this.updateedAt,
        deleteddAt: deleteddAt.present ? deleteddAt.value : this.deleteddAt,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, categoryName, color, icon, createdAt, updateedAt, deleteddAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt &&
          other.updateedAt == this.updateedAt &&
          other.deleteddAt == this.deleteddAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<String> color;
  final Value<String> icon;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateedAt;
  final Value<DateTime?> deleteddAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateedAt = const Value.absent(),
    this.deleteddAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String categoryName,
    required String color,
    required String icon,
    required DateTime createdAt,
    required DateTime updateedAt,
    this.deleteddAt = const Value.absent(),
  })  : categoryName = Value(categoryName),
        color = Value(color),
        icon = Value(icon),
        createdAt = Value(createdAt),
        updateedAt = Value(updateedAt);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? categoryName,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateedAt,
    Expression<DateTime>? deleteddAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (updateedAt != null) 'updateed_at': updateedAt,
      if (deleteddAt != null) 'deletedd_at': deleteddAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? categoryName,
      Value<String>? color,
      Value<String>? icon,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateedAt,
      Value<DateTime?>? deleteddAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updateedAt: updateedAt ?? this.updateedAt,
      deleteddAt: deleteddAt ?? this.deleteddAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updateedAt.present) {
      map['updateed_at'] = Variable<DateTime>(updateedAt.value);
    }
    if (deleteddAt.present) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }
}

class $ToDosTable extends ToDos with TableInfo<$ToDosTable, ToDo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToDosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _category_idMeta =
      const VerificationMeta('category_id');
  @override
  late final GeneratedColumn<int> category_id = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 256),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateedAtMeta =
      const VerificationMeta('updateedAt');
  @override
  late final GeneratedColumn<DateTime> updateedAt = GeneratedColumn<DateTime>(
      'updateed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deleteddAtMeta =
      const VerificationMeta('deleteddAt');
  @override
  late final GeneratedColumn<DateTime> deleteddAt = GeneratedColumn<DateTime>(
      'deletedd_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category_id,
        title,
        description,
        date,
        time,
        isCompleted,
        createdAt,
        updateedAt,
        deleteddAt
      ];
  @override
  String get aliasedName => _alias ?? 'to_dos';
  @override
  String get actualTableName => 'to_dos';
  @override
  VerificationContext validateIntegrity(Insertable<ToDo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _category_idMeta,
          category_id.isAcceptableOrUnknown(
              data['category_id']!, _category_idMeta));
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updateed_at')) {
      context.handle(
          _updateedAtMeta,
          updateedAt.isAcceptableOrUnknown(
              data['updateed_at']!, _updateedAtMeta));
    } else if (isInserting) {
      context.missing(_updateedAtMeta);
    }
    if (data.containsKey('deletedd_at')) {
      context.handle(
          _deleteddAtMeta,
          deleteddAt.isAcceptableOrUnknown(
              data['deletedd_at']!, _deleteddAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ToDo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ToDo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updateedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updateed_at'])!,
      deleteddAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deletedd_at']),
    );
  }

  @override
  $ToDosTable createAlias(String alias) {
    return $ToDosTable(attachedDatabase, alias);
  }
}

class ToDo extends DataClass implements Insertable<ToDo> {
  final int id;
  final int? category_id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updateedAt;
  final DateTime? deleteddAt;
  const ToDo(
      {required this.id,
      this.category_id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.isCompleted,
      required this.createdAt,
      required this.updateedAt,
      this.deleteddAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || category_id != null) {
      map['category_id'] = Variable<int>(category_id);
    }
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<String>(time);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updateed_at'] = Variable<DateTime>(updateedAt);
    if (!nullToAbsent || deleteddAt != null) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt);
    }
    return map;
  }

  ToDosCompanion toCompanion(bool nullToAbsent) {
    return ToDosCompanion(
      id: Value(id),
      category_id: category_id == null && nullToAbsent
          ? const Value.absent()
          : Value(category_id),
      title: Value(title),
      description: Value(description),
      date: Value(date),
      time: Value(time),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      updateedAt: Value(updateedAt),
      deleteddAt: deleteddAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteddAt),
    );
  }

  factory ToDo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToDo(
      id: serializer.fromJson<int>(json['id']),
      category_id: serializer.fromJson<int?>(json['category_id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<String>(json['time']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateedAt: serializer.fromJson<DateTime>(json['updateedAt']),
      deleteddAt: serializer.fromJson<DateTime?>(json['deleteddAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category_id': serializer.toJson<int?>(category_id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<String>(time),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateedAt': serializer.toJson<DateTime>(updateedAt),
      'deleteddAt': serializer.toJson<DateTime?>(deleteddAt),
    };
  }

  ToDo copyWith(
          {int? id,
          Value<int?> category_id = const Value.absent(),
          String? title,
          String? description,
          DateTime? date,
          String? time,
          bool? isCompleted,
          DateTime? createdAt,
          DateTime? updateedAt,
          Value<DateTime?> deleteddAt = const Value.absent()}) =>
      ToDo(
        id: id ?? this.id,
        category_id: category_id.present ? category_id.value : this.category_id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        updateedAt: updateedAt ?? this.updateedAt,
        deleteddAt: deleteddAt.present ? deleteddAt.value : this.deleteddAt,
      );
  @override
  String toString() {
    return (StringBuffer('ToDo(')
          ..write('id: $id, ')
          ..write('category_id: $category_id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category_id, title, description, date,
      time, isCompleted, createdAt, updateedAt, deleteddAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToDo &&
          other.id == this.id &&
          other.category_id == this.category_id &&
          other.title == this.title &&
          other.description == this.description &&
          other.date == this.date &&
          other.time == this.time &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.updateedAt == this.updateedAt &&
          other.deleteddAt == this.deleteddAt);
}

class ToDosCompanion extends UpdateCompanion<ToDo> {
  final Value<int> id;
  final Value<int?> category_id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<String> time;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateedAt;
  final Value<DateTime?> deleteddAt;
  const ToDosCompanion({
    this.id = const Value.absent(),
    this.category_id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateedAt = const Value.absent(),
    this.deleteddAt = const Value.absent(),
  });
  ToDosCompanion.insert({
    this.id = const Value.absent(),
    this.category_id = const Value.absent(),
    required String title,
    required String description,
    required DateTime date,
    required String time,
    this.isCompleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updateedAt,
    this.deleteddAt = const Value.absent(),
  })  : title = Value(title),
        description = Value(description),
        date = Value(date),
        time = Value(time),
        createdAt = Value(createdAt),
        updateedAt = Value(updateedAt);
  static Insertable<ToDo> custom({
    Expression<int>? id,
    Expression<int>? category_id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? time,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateedAt,
    Expression<DateTime>? deleteddAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category_id != null) 'category_id': category_id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updateedAt != null) 'updateed_at': updateedAt,
      if (deleteddAt != null) 'deletedd_at': deleteddAt,
    });
  }

  ToDosCompanion copyWith(
      {Value<int>? id,
      Value<int?>? category_id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? date,
      Value<String>? time,
      Value<bool>? isCompleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateedAt,
      Value<DateTime?>? deleteddAt}) {
    return ToDosCompanion(
      id: id ?? this.id,
      category_id: category_id ?? this.category_id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updateedAt: updateedAt ?? this.updateedAt,
      deleteddAt: deleteddAt ?? this.deleteddAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category_id.present) {
      map['category_id'] = Variable<int>(category_id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updateedAt.present) {
      map['updateed_at'] = Variable<DateTime>(updateedAt.value);
    }
    if (deleteddAt.present) {
      map['deletedd_at'] = Variable<DateTime>(deleteddAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToDosCompanion(')
          ..write('id: $id, ')
          ..write('category_id: $category_id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ToDosTable toDos = $ToDosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categories, toDos];
}
