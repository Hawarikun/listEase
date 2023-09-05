import 'dart:io';

import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:list_ease/models/ToDosWithCategory.dart';
import 'package:list_ease/services/database/categories_table.dart';
import 'package:list_ease/services/database/todos_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [Categories, ToDos],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Future<List<Category>> allCategories() async {
    final data = await select(categories).get();
    return data;
  }

  Future<List<ToDosWithCategory>> allTodos() async {
    final query = select(toDos).join(
      [
        innerJoin(
          categories,
          categories.id.equalsExp(toDos.category_id),
        ),
      ],
    );

    final data = await query.get();

    return data.map(
      (row) {
        return ToDosWithCategory(
            row.readTable(toDos), row.readTable(categories));
      },
    ).toList();
  }

  Future updateKategoriRepo(
      int id, String name, String icon, String color) async {
    return (update(categories)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(
      CategoriesCompanion(
        categoryName: Value(name),
        icon: Value(icon),
        color: Value(color),
      ),
    );
  }

  Future updateIsCompleteToDos(int id, bool value) {
    return (update(toDos)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(
      ToDosCompanion(
        isCompleted: Value(value),
      ),
    );
  }

  Future deleteKategoriRepo(int id) async {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<ToDosWithCategory>> getToDosByDateRepo(DateTime date, bool isComplete) {
    final query = select(toDos).join(
      [
        innerJoin(
          categories,
          categories.id.equalsExp(toDos.category_id),
        ),
      ],
    )..where(toDos.date.equals(date) & toDos.isCompleted.equals(isComplete));

    return query.watch().map(
      (rows) {
        return rows.map((row) {
          return ToDosWithCategory(
              row.readTable(toDos), row.readTable(categories));
        }).toList();
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
