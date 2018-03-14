import 'package:flutter/material.dart';
import 'package:startup_namer/random_words.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(
        primaryColor: Colors.orange,
    ),
    home: new Beers(),
    );
  }
}