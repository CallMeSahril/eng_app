class Tile {
  final int id;
  final int levelId;
  final int position;
  final String type;
  final String icon;
  final String status;

  Tile({
    required this.id,
    required this.levelId,
    required this.position,
    required this.type,
    required this.icon,
    required this.status,
  });

  factory Tile.fromJson(Map<String, dynamic> json) {
    return Tile(
      id: json['id'],
      levelId: json['level_id'],
      position: json['position'],
      type: json['type'],
      icon: json['icon'],
      status: json['status'],
    );
  }
}

class StoryLevel {
  final int id;
  final String name;
  final String theme;
  final String backgroundImage;
  final List<Tile> tiles;

  StoryLevel({
    required this.id,
    required this.name,
    required this.theme,
    required this.backgroundImage,
    required this.tiles,
  });

  factory StoryLevel.fromJson(Map<String, dynamic> json) => StoryLevel(
    id: json['id'],
    name: json['name'],
    theme: json['theme'],
    backgroundImage: json['background_image'],
    tiles: (json['tiles'] as List).map((e) => Tile.fromJson(e)).toList(),
  );
}
