class Achievement {
  final int tileId;
  final String achievementName;
  final String createdAt;
  final String gambar;

  Achievement({
    required this.tileId,
    required this.achievementName,
    required this.createdAt,
    required this.gambar,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      gambar: json['gambar'],
      tileId: json['tile_id'],
      achievementName: json['achievement_name'],
      createdAt: json['created_at'],
    );
  }
}

class UserAchievement {
  final int id;
  final int userId;
  final String name;
  final String email;
  final List<Achievement> achievements;

  UserAchievement({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.achievements,
  });

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      achievements: List<Achievement>.from(
        json['achievement'].map((x) => Achievement.fromJson(x)),
      ),
    );
  }
}
