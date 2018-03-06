import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/saved_suggestions.dart';
import 'package:startup_namer/word_pair_context.dart';

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPairContext>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadyJudged = _saved.map((p) => p.wordPair).contains(pair);
    final WordPairContext wordPairContext = _saved.firstWhere((p) => p.wordPair == pair, orElse: () => null);

    Column buildButtonColumn(IconData icon, Color color, handlePress) {

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new IconButton(icon: new Icon(icon, color: color), onPressed: handlePress),
        ],
      );
    }

    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Expanded(
            child: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          ),
          buildButtonColumn(Icons.thumb_up, alreadyJudged && wordPairContext.isLiked ? Colors.green : Colors.black26, (pair) {
            return () {
              setState(() {
                if (alreadyJudged && wordPairContext.isLiked) {
                  _saved.removeWhere((p) => p.wordPair == pair);
                } else {
                  _saved.removeWhere((p) => p.wordPair == pair);
                  _saved.add(new WordPairContext(pair, isLiked: true));
                }
              });
            };
          }(pair)),
          new Container(
            margin: const EdgeInsets.only(left: 80.0, right: 30.0),
            child: buildButtonColumn(Icons.thumb_down, alreadyJudged && !wordPairContext.isLiked ? Colors.green : Colors.black26, (pair) {
              return () {
                setState(() {
                  if (alreadyJudged && !wordPairContext.isLiked) {
                    _saved.removeWhere((p) => p.wordPair == pair);
                  } else {
                    _saved.removeWhere((p) => p.wordPair == pair);
                    _saved.add(new WordPairContext(pair, isLiked: false));
                  }
                });
              };
            }(pair))
          ),
        ],
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new SavedSuggestions(saved: _saved);
        },
      ),
    );
  }

}
