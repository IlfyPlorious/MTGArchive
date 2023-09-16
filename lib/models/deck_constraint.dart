abstract class DeckConstraints {
  abstract int minDeckSize;
  abstract int? maxDeckSize;
  abstract int? minSideboardSize;
  abstract int maxSideboardSize;
  abstract int maxNumberOfCopies;

  @override
  String toString() =>
      'min deck size: $minDeckSize\n max deck size: $maxDeckSize';
}

class StandardConstraints extends DeckConstraints {
  @override
  int? maxDeckSize;

  @override
  int maxNumberOfCopies = 4;

  @override
  int maxSideboardSize = 15;

  @override
  int minDeckSize = 60;

  @override
  int? minSideboardSize;

  @override
  String toString() => 'min deck size: $minDeckSize'
      '\n max deck size: $maxDeckSize'
      '\n max number of copies: $maxNumberOfCopies'
      '\n max sideboard size: $maxSideboardSize';
}

class PioneerConstraints extends StandardConstraints {}

class HistoricConstraints extends StandardConstraints {}

class LegacyConstraints extends StandardConstraints {}

class VintageConstraints extends StandardConstraints {}

class PauperConstraints extends StandardConstraints {}

class CommanderConstraints extends DeckConstraints {
  @override
  int? maxDeckSize = 100;

  @override
  int maxNumberOfCopies = 1;

  @override
  int maxSideboardSize = 0;

  @override
  int minDeckSize = 100;

  @override
  int? minSideboardSize;

  @override
  String toString() => 'min deck size: $minDeckSize'
      '\n max deck size: $maxDeckSize'
      '\n max number of copies: $maxNumberOfCopies'
      '\n max sideboard size: $maxSideboardSize';
}

class BrawlConstraints extends DeckConstraints {
  @override
  int? maxDeckSize = 60;

  @override
  int maxNumberOfCopies = 1;

  @override
  int maxSideboardSize = 0;

  @override
  int minDeckSize = 60;

  @override
  int? minSideboardSize;
}
