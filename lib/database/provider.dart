import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

final String columnId = 'id';
final String columnRecipeseId = 'RecipeseId';
final String columnRecipesTitle = 'recipesTitle';
final String columnIsChecked = 'isChecked';
final String recipesTable = 'recipes_table';

class RecipesProvider {
  late Database db;

  static final RecipesProvider instance = RecipesProvider._internal();

  factory RecipesProvider() {
    return instance;
  }

  RecipesProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'recipes.db'),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('''
create table $recipesTable ( 
  $columnId integer primary key autoincrement,
  $columnRecipeseId integer not null, 
  $columnRecipesTitle integer not null,
  $columnIsChecked integer not null
  )
''');
        });
  }

  Future<RecipesDatabase> insert(RecipesDatabase recipesDatabase) async {
    recipesDatabase.id = await db.insert(recipesTable, recipesDatabase.toMap());
    return recipesDatabase;
  }

  Future<List<RecipesDatabase>> getRecipes() async {
    List<Map<String, dynamic>> recipesMaps = await db.query(recipesTable);
    if (recipesMaps.isEmpty) {
      return [];
    } else {
      List<RecipesDatabase> recipes = [];
      recipesMaps.forEach((element) {
        recipes.add(RecipesDatabase.fromMap(element));
      });
      return recipes;
    }
  }

  Future<int> delete(int id) async {
    return await db.delete(recipesTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(RecipesDatabase recipesDatabase) async {
    return await db.update(recipesTable, recipesDatabase.toMap(),
        where: '$columnId = ?', whereArgs: [recipesDatabase.id]);
  }

  Future close() async => db.close();
}
