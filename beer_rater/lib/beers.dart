import 'dart:async';

import 'package:flutter/material.dart';
import 'package:beer_rater/beer.dart';

class Beers extends StatefulWidget {
  @override
  createState() => new BeersState();
}

class BeersState extends State<Beers> {
  var _saved = new List<Beer>();

  Beer _newBeer = null;

  final _biggerFont = const TextStyle(fontSize: 18.0);

  initState() async {
    _saved = await Beer.getBeers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Beer with Friends'),
      ),
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add beer',
        child: new Icon(Icons.local_drink),
        onPressed: _addBeer,
      ),
    );
  }

  Future<DismissDialogAction> _addBeer() async {
    String _beer;
    String _brewer;
    return await showDialog<DismissDialogAction>(
      context: context,
      child: new _SystemPadding(
          child: new SimpleDialog(
          title: const Text('Add a beer'),
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'What are you drinking?',
                      hintText: 'e.g. Misconstrued Sarcasm'
                  ),
                  onChanged: (beer) {
                    _beer = beer;
                  },
                )
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Who brewed it?',
                      hintText: 'e.g. Random Precision Brewing Company'
                  ),
                  onChanged: (brewer) {
                    _brewer = brewer;
                  },
              )
            ),
            new ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      setState(() {
                        _saved.add(new Beer(_brewer, _beer));
                      });
                      Navigator.pop(context, DismissDialogAction.save);
                    },
                    child: new Text("ADD")),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, DismissDialogAction.cancel);
                    },
                    child: new Text("CANCEL")),
                ],
            ),
          ],
        )
      )
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index < _saved.length) {
            return _buildRow(_saved.elementAt(index));
          }
        }
    );
  }

  Widget _buildRow(Beer beer) {
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
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    beer.name,
                    style: _biggerFont,
                  ),
                ),
                new Text(
                  beer.brewer,
                ),
              ],
            ),
          ),
          buildButtonColumn(Icons.thumb_up, beer.isRated() && beer.isLiked ? Colors.green : Colors.black26, (beer) {
            return () {
              setState(() {
                beer.isLiked = true;
              });
            };
          }(beer)),
          new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 0.0),
            child: buildButtonColumn(Icons.thumb_down, beer.isRated() && !beer.isLiked ? Colors.green : Colors.black26, (beer) {
              return () {
                setState(() {
                  beer.isLiked = false;
                });
              };
            }(beer))
          ),
        ],
      ),
    );
  }

}

enum DismissDialogAction {
  cancel,
  save,
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
