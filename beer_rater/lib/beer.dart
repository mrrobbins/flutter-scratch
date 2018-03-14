class Beer {
  final String name;
  bool isLiked;

  Beer(this.name, {this.isLiked});

  isRated() {
    return isLiked != null;
  }
}