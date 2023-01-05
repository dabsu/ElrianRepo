import "package:flutter/material.dart";
import 'package:modernlogintute/home_page.dart';
import 'package:modernlogintute/read%20data/get_user_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
