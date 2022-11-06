import 'package:flutter/material.dart';
import 'package:inter1/Navigetion.dart';
import 'package:inter1/database/model.dart';
import 'package:inter1/details_screen.dart';

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
          print(snapshot.data);
          recipesList = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Text(
                  'Favourite List',
                  style: TextStyle(fontSize: 22),
                )),
              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: recipesList.length,
                        itemBuilder: (context, index) {
                          RecipesDatabase recipes = recipesList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                recipesList[index].recipesTitle,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              subtitle: Text('${recipes.recipesId}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      RecipesProvider.instance
                                          .delete(recipes.id!);
                                      recipes.isChecked = false;
                                      RecipesProvider.instance.update(
                                          RecipesDatabase(
                                              recipesId: recipes.id!,
                                              recipesTitle: recipes.recipesTitle,
                                              isChecked: recipes.isChecked));
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 40,
                                  )),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(id: recipes.recipesId),
                                ));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
