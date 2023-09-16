class SetsRequest {
  String? name;
  String? block;

  SetsRequest({this.name, this.block});

  factory SetsRequest.getRequest(Map<String, dynamic> request) =>
      SetsRequest(name: request['name'], block: request['block']);

  Map<String, dynamic> toJson() => {'name': name, 'block': block};
}

class SetsFilters {
  SetsFilters(
      {DateTime? releaseDate,
      Expansions? expansions,
      bool? onlineOnly,
      bool? afterFilterDate})
      : releaseDate = releaseDate ?? DateTime.now(),
        expansions = expansions ?? Expansions.any,
        onlineOnly = onlineOnly ?? false,
        afterFilterDate = afterFilterDate ?? false;

  DateTime releaseDate;
  bool afterFilterDate;
  Expansions expansions;
  bool onlineOnly;

  String get dateAsString =>
      '${releaseDate.day > 9 ? releaseDate.day : '0${releaseDate.day}'} / ${releaseDate.month > 9 ? releaseDate.month : '0${releaseDate.month}'} / ${releaseDate.year}';

  @override
  String toString() =>
      'releaseDate: $dateAsString\nafterDate: $afterFilterDate\nonlineOnly: $onlineOnly\nexpansions: ${expansions.getApiKey()}';
}

enum Expansions {
  any,
  core,
  reprint,
  box,
  un,
  fromTheVault,
  premiumDeck,
  duelDeck,
  starter,
  commander,
  planeChase,
  archenemy,
  promo,
  vanguard,
  masters
}

extension ExpansionsX on Expansions {
  String? getApiKey() {
    switch (this) {
      case Expansions.fromTheVault:
        return 'from the vault';
      case Expansions.premiumDeck:
        return 'premium deck';
      case Expansions.duelDeck:
        return 'duel deck';
      case Expansions.planeChase:
        return 'planechase';
      case Expansions.any:
        return null;
      default:
        return name;
    }
  }
}
