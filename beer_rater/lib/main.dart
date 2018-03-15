import 'package:flutter/material.dart';
import 'package:beer_rater/beers.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Beer Rater',
        theme: new ThemeData(
        primaryColor: Colors.orange,
    ),
    home: new Beers(),
    );
  }
}