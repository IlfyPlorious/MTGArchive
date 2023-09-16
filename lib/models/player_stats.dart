class PlayerStats {
  final String statsName;
  final bool enabled;
  final int count;
  final String? iconUrl;

  PlayerStats(
      {this.statsName = "commander_damage",
      this.enabled = false,
      this.count = 0,
      this.iconUrl});
}
