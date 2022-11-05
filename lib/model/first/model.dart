import 'package:inter1/model/first/results.dart';

class Recipes {
  late List<Results> results;

  Recipes({
    required this.results,
  });

  Recipes.fromMap(Map<String, dynamic> map) {
    this.results = [];
    (map['results'] as List).forEach((element) {
      this.results.add(Results.fromMap(element));
    });
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> results = [];
    this.results.forEach((element) {results.add(element.toMap());});
    Map<String, dynamic> map = {
      'results' : results,
    };
    return map;
  }
}
