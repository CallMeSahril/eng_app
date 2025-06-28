class Story {
  final int id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final bool isFavorite;
  final bool isWatched;
  final int progressSeconds;

  Story({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.isFavorite,
    required this.isWatched,
    required this.progressSeconds,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['video_url'],
      thumbnailUrl: json['thumbnail_url'],
      isFavorite: json['is_favorite'],
      isWatched: json['is_watched'],
      progressSeconds: json['progress_seconds'],
    );
  }
}
