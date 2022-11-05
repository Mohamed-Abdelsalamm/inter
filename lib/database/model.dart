import 'package:inter1/database/provider.dart';

class RecipesDatabase {
  int? id;
  late int recipesId;
  late String recipesTitle;
  late bool isChecked;

  RecipesDatabase({
    this.id,
    required this.recipesId,
    required this.recipesTitle,
    required this.isChecked,
  });

  RecipesDatabase.fromMap(Map<String, dynamic> data) {
    if (data[columnId] != null) this.id = data[columnId];
    this.recipesId = data[columnRecipeseId];
    this.recipesTitle = data[columnRecipesTitle];
    this.isChecked = data[columnIsChecked] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    Map <String , dynamic> data = {};
    if (this.id != null) data[columnId] = this.id;
    data[columnRecipesTitle] = this.recipesTitle;
    data[columnIsChecked] = this.isChecked ? 1 : 0;
    return data;
  }
}
