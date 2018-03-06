import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/word_pair_context.dart';

class SavedSuggestions extends StatefulWidget {
  SavedSuggestions({Key key, this.saved}) : super(key: key);

  final Set<WordPairContext> saved;

  @override
  SavedSuggestionsState createState() => new SavedSuggestionsState();
}

class SavedSuggestionsState extends State<SavedSuggestions> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _handleRemoveFavorite(WordPairContext pair) {
    setState(() {
      widget.saved.removeWhere((p) => p.wordPair == pair.wordPair);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tiles = widget.saved.map(
          (pair) {
        return new WordPairListItem(pair: pair, onUnfavorite: _handleRemoveFavorite);
      },
    );

    final divided = ListTile
        .divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Saved Suggestions.'),
      ),
      body: new ListView(children: divided),
    );
  }
}

typedef void UnfavoriteCallback(WordPairContext pair);

class WordPairListItem extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  WordPairListItem({WordPairContext pair, this.onUnfavorite})
      : pair = pair,
        super(key: new ObjectKey(pair));

  final WordPairContext pair;
  final UnfavoriteCallback onUnfavorite;

  @override
  Widget build(BuildContext context) {
    Column buildButtonColumn(IconData icon, Color color) {

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new IconButton(icon: new Icon(icon, color: color), onPressed: () { onUnfavorite(pair);}),
        ],
      );
    }

    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Expanded(
            child: new Text(
              pair.wordPair.asPascalCase,
              style: _biggerFont,
            ),
          ),
          buildButtonColumn(Icons.thumb_up, pair.isLiked ? Colors.green : Colors.black26),
          new Container(
              margin: const EdgeInsets.only(left: 80.0, right: 30.0),
              child: buildButtonColumn(Icons.thumb_down, !pair.isLiked ? Colors.green : Colors.black26)
          ),
        ],
      ),
    );
  }
}