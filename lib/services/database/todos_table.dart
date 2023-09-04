import 'package:drift/drift.dart';
import 'package:list_ease/services/database/categories_table.dart';

// @DataClassName("Todos")
class ToDos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get category_id => integer().nullable().references(Categories, #id)();
  // IntColumn get categoryId =>
  //     integer().customConstraint("REFERENCES category(id) NOT NULL")();
  TextColumn get title => text().withLength(max: 128)();
  TextColumn get description => text().withLength(max: 256)();
  DateTimeColumn get date => dateTime()();
  TextColumn get time => text().withLength(max: 128)();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateedAt => dateTime()();
  DateTimeColumn get deleteddAt => dateTime().nullable()();
}
