import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/sec/details_model.dart';
class DetailsAPI {
  Future<Details> getData( int id) async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$id/information?apiKey=cec064ec07d94c28a639cc495d0ca92f'));
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final Map<String ,dynamic> body = jsonDecode(response.body);
      Details recipesDetails = Details.fromMap(body);
      return recipesDetails;
    } else {
      throw('error'+ response.body);
    }
  }
}