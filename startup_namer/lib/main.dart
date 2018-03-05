import 'package:flutter/material.dart';
import 'package:startup_namer/random_words.dart';

void main() => runApp(new MaterialApp(
  title: 'Startup Name Generator',
  theme: new ThemeData(
    primaryColor: new Color.fromARGB(255, 0, 153, 0),
  ),
  home: new RandomWords(),
));