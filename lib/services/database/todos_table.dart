

import 'package:drift/drift.dart';


@DataClassName("Todos")
class ToDos extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(max: 128)();
  TextColumn get description => text().withLength(max: 256)();
  DateTimeColumn get dateWithTime => dateTime()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateedAt => dateTime()();
  DateTimeColumn get deleteddAt => dateTime().nullable()();
}