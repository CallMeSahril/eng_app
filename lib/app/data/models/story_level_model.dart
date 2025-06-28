class Tile {
  final String icon;
  final String status;

  Tile({required this.icon, required this.status});

  factory Tile.fromJson(Map<String, dynamic> json) {
    return Tile(
      icon: json['icon'],
      status: json['status'],
    );
  }
}

class StoryLevel {
  final int id;
  final String backgroundImage;
  final List<Tile> tiles;

  StoryLevel({
    required this.id,
    required this.backgroundImage,
    required this.tiles,
  });

  factory StoryLevel.fromJson(Map<String, dynamic> json) {
    var tiles = (json['tiles'] as List)
        .map((tileJson) => Tile.fromJson(tileJson))
        .toList();

    return StoryLevel(
      id: json['id'],
      backgroundImage: json['backgroundImage'],
      tiles: tiles,
    );
  }
}
