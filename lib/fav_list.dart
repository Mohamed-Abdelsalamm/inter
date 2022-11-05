import 'package:flutter/material.dart';
import 'package:inter1/database/model.dart';

import 'database/provider.dart';

class FavList extends StatefulWidget {
  @override
  State<FavList> createState() => _FavListState();
}

List<RecipesDatabase> recipesList = [];

class _FavListState extends State<FavList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecipesDatabase>>(
      future: RecipesProvider.instance.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        if (snapshot.hasData) {
          print(snapshot.data
          );
          recipesList = snapshot.data!;
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: recipesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(recipesList[index].recipesTitle,style: TextStyle(color: Colors.black,fontSize: 40),),
                        subtitle: Text('${recipesList[index].recipesId}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        ));
      },
    );
  }
}
