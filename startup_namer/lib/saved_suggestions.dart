import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedSuggestions extends StatefulWidget {
  SavedSuggestions({Key key, this.saved}) : super(key: key);

  final Set<WordPair> saved;

  @override
  _SavedSuggestionsState createState() => new _SavedSuggestionsState();
}

class _SavedSuggestionsState extends State<SavedSuggestions> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _handleRemoveFavorite(WordPair pair) {
    setState(() {
      widget.saved.remove(pair);
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

typedef void UnfavoriteCallback(WordPair pair);

class WordPairListItem extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  WordPairListItem({WordPair pair, this.onUnfavorite})
      : pair = pair,
        super(key: new ObjectKey(pair));

  final WordPair pair;
  final UnfavoriteCallback onUnfavorite;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        onTap: () {
          onUnfavorite(pair);
        }
    );
  }
}