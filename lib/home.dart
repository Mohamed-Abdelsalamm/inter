import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inter1/details_screen.dart';
import 'package:inter1/model/first/model.dart';
import 'package:inter1/network/first_api/recipes_list_api.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Recipes responseObject;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Recipes>(
        future: RecipesAPI().getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            responseObject = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Intermedit'),
              ),
              body: Container(
                width: double.infinity,
                child: GridView.count(
                  padding: EdgeInsets.all(10),
                  crossAxisCount: 2,
                  children: List<Widget>.generate(
                    responseObject.results.length,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    id: responseObject.results[index].id,
                                  ),
                                ));
                          },
                          child: GridTile(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                margin: EdgeInsets.all(10),
                                color: Colors.black26,
                                child: Center(
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        child: Image.network(
                                            '${responseObject.results[index].image}'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 5),
                                        child: Center(
                                          child: Text(
                                            responseObject.results[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text('${snapshot.error.toString()}');
          }
          return Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        },
      ),
    );
  }
}
