import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inter1/model/first/model.dart';

class RecipesAPI {
  Future<Recipes> getData() async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?apiKey=cec064ec07d94c28a639cc495d0ca92f'));
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final Map<String ,dynamic> body = jsonDecode(response.body);
      Recipes recipes = Recipes.fromMap(body);
      return recipes;
    } else {
    throw('error'+ response.body);
    }
  }
}
