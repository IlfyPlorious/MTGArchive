import 'package:playground/models/player_stats.dart';

class PlayerData {
  int health;
  final List<PlayerStats> playerStats;
  String backgroundUrl;
  String name;
  String? die;

  String get getDiePath => 'assets/images/$die.png';

  PlayerData(
      {this.health = 20,
      this.backgroundUrl = "orange",
      this.name = "Player",
      this.die,
      List<PlayerStats>? playerStats})
      : playerStats = playerStats ?? <PlayerStats>[];

  PlayerData copyWith(
      {int? health,
      List<PlayerStats>? playerStats,
      String? backgroundUrl,
      String? name,
      String? die}) {
    return PlayerData(
      health: health ?? this.health,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      name: name ?? this.name,
      playerStats: playerStats ?? this.playerStats,
      die: die == 'null' ? null : die ?? this.die,
    );
  }
}
