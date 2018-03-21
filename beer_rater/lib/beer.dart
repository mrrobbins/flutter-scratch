import 'dart:async';

import 'package:beer_rater/utils.dart';

class Beer {

  final String brewer;

  final String name;

  bool isLiked;

  Beer(this.brewer, this.name, {this.isLiked});

  isRated() {
    return isLiked != null;
  }

  static Future getBeers() async {
    var data = await read_yaml_asset("assets/beer_data.yml");
    List<Beer> beers = data["beers"].map((beer) =>
    new Beer(beer["brewer"], beer["name"], isLiked: beer["liked"])
    ).toList();
    return beers;
  }
}