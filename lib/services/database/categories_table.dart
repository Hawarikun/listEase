import 'package:drift/drift.dart';

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryName => text().withLength(max: 100)();
  TextColumn get color => text().withLength(max: 50)();
  TextColumn get icon => text().withLength(max: 50)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateedAt => dateTime()();
  DateTimeColumn get deleteddAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
