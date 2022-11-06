import 'package:flutter/material.dart';
import 'package:inter1/home.dart';

import 'Navigetion.dart';
import 'database/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RecipesProvider.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Navigation(),
    );
  }
}
