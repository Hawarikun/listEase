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

class $ToDosTable extends ToDos with TableInfo<$ToDosTable, Todos> {
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
  static const VerificationMeta _dateWithTimeMeta =
      const VerificationMeta('dateWithTime');
  @override
  late final GeneratedColumn<DateTime> dateWithTime = GeneratedColumn<DateTime>(
      'date_with_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
      [id, title, description, dateWithTime, createdAt, updateedAt, deleteddAt];
  @override
  String get aliasedName => _alias ?? 'to_dos';
  @override
  String get actualTableName => 'to_dos';
  @override
  VerificationContext validateIntegrity(Insertable<Todos> instance,
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date_with_time')) {
      context.handle(
          _dateWithTimeMeta,
          dateWithTime.isAcceptableOrUnknown(
              data['date_with_time']!, _dateWithTimeMeta));
    } else if (isInserting) {
      context.missing(_dateWithTimeMeta);
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
  Todos map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todos(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      dateWithTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_with_time'])!,
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

class Todos extends DataClass implements Insertable<Todos> {
  final int id;
  final String title;
  final String description;
  final DateTime dateWithTime;
  final DateTime createdAt;
  final DateTime updateedAt;
  final DateTime? deleteddAt;
  const Todos(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateWithTime,
      required this.createdAt,
      required this.updateedAt,
      this.deleteddAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['date_with_time'] = Variable<DateTime>(dateWithTime);
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
      title: Value(title),
      description: Value(description),
      dateWithTime: Value(dateWithTime),
      createdAt: Value(createdAt),
      updateedAt: Value(updateedAt),
      deleteddAt: deleteddAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deleteddAt),
    );
  }

  factory Todos.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todos(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      dateWithTime: serializer.fromJson<DateTime>(json['dateWithTime']),
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
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'dateWithTime': serializer.toJson<DateTime>(dateWithTime),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateedAt': serializer.toJson<DateTime>(updateedAt),
      'deleteddAt': serializer.toJson<DateTime?>(deleteddAt),
    };
  }

  Todos copyWith(
          {int? id,
          String? title,
          String? description,
          DateTime? dateWithTime,
          DateTime? createdAt,
          DateTime? updateedAt,
          Value<DateTime?> deleteddAt = const Value.absent()}) =>
      Todos(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dateWithTime: dateWithTime ?? this.dateWithTime,
        createdAt: createdAt ?? this.createdAt,
        updateedAt: updateedAt ?? this.updateedAt,
        deleteddAt: deleteddAt.present ? deleteddAt.value : this.deleteddAt,
      );
  @override
  String toString() {
    return (StringBuffer('Todos(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateWithTime: $dateWithTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateedAt: $updateedAt, ')
          ..write('deleteddAt: $deleteddAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, description, dateWithTime, createdAt, updateedAt, deleteddAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todos &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dateWithTime == this.dateWithTime &&
          other.createdAt == this.createdAt &&
          other.updateedAt == this.updateedAt &&
          other.deleteddAt == this.deleteddAt);
}

class ToDosCompanion extends UpdateCompanion<Todos> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> dateWithTime;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateedAt;
  final Value<DateTime?> deleteddAt;
  const ToDosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dateWithTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateedAt = const Value.absent(),
    this.deleteddAt = const Value.absent(),
  });
  ToDosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime dateWithTime,
    required DateTime createdAt,
    required DateTime updateedAt,
    this.deleteddAt = const Value.absent(),
  })  : title = Value(title),
        description = Value(description),
        dateWithTime = Value(dateWithTime),
        createdAt = Value(createdAt),
        updateedAt = Value(updateedAt);
  static Insertable<Todos> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dateWithTime,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateedAt,
    Expression<DateTime>? deleteddAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dateWithTime != null) 'date_with_time': dateWithTime,
      if (createdAt != null) 'created_at': createdAt,
      if (updateedAt != null) 'updateed_at': updateedAt,
      if (deleteddAt != null) 'deletedd_at': deleteddAt,
    });
  }

  ToDosCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? dateWithTime,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateedAt,
      Value<DateTime?>? deleteddAt}) {
    return ToDosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateWithTime: dateWithTime ?? this.dateWithTime,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dateWithTime.present) {
      map['date_with_time'] = Variable<DateTime>(dateWithTime.value);
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
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateWithTime: $dateWithTime, ')
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
