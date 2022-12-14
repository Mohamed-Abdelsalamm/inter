import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inter1/database/provider.dart';
import 'package:inter1/fav_list.dart';
import 'package:inter1/model/sec/details_model.dart';
import 'database/model.dart';
import 'network/sec_api/details_api.dart';

class DetailsScreen extends StatefulWidget {
  late int id;

  DetailsScreen({required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Details responseObject;

  final Future<List<RecipesDatabase>> data = RecipesProvider.instance.getRecipes();
  bool heart = false;
      // recipesList[0].isChecked;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DetailsAPI().getData(this.widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            responseObject = snapshot.data;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Center(
                      child: Text(
                    "Recipes Details",
                    style: TextStyle(fontSize: 24),
                  )),
                  backgroundColor: Colors.red,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () async {
                            heart = !heart;
                            print(heart);
                            setState(() {
                              RecipesProvider.instance.insert(RecipesDatabase(
                                  isChecked: heart,
                                  recipesId: responseObject.id,
                                  recipesTitle: '${responseObject.title}'),);
                            });
                        },
                        icon: heart
                            ? Icon(
                                Icons.favorite,
                                size: 30,
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 30,
                              ),
                      ),
                    ),
                  ],
                ),
                body: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      /*crossAxisAlignment: CrossAxisAlignment.center,*/
                      children: [
                        Image.network("${responseObject.image}"),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            responseObject.title,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Html(data: '${responseObject.instructions}',),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        });
  }
}
