class Format {
  static const commander = 'Commander';
  static const duel = 'Duel';
  static const standard = 'Standard';
}

class LegalityStatus {
  static const legal = 'Legal';
  static const banned = 'Banned';
  static const restricted = 'Restricted';
}

class NetworkInfo {
  static const apiUrl = 'https://api.magicthegathering.io/v1';
  static const scryfallApiUrl = 'https://api.scryfall.com';
  static const headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Page-Size': 50,
    'Charset': 'utf-8'
  };
  static const scryfallHeaders = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
}

const String emptyString = '';

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.success;

  bool get isFailure => this == Status.failure;
}
