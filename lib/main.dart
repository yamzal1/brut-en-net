import 'package:flutter/material.dart';
import 'package:tp4/pages/homepage.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  static final String title = 'BRUT NET';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: HomePage(),
  );
}
