import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/responsemodels/card.dart' as response;
import 'package:playground/network/responsemodels/scryfall/mtg_symbol.dart';
import 'package:playground/utils/constants.dart';

class StringUtils {
  static String buildLimitedString({String? string, required int size}) {
    return (string?.length ?? 0) > size
        ? '${string?.substring(0, size) ?? 'Missing'}...'
        : string ?? 'Missing';
  }
}

class Utils {
  static Map<T, R> toCustomMap<T, R>(List<T> keys, R initVal) {
    var returnMap = <T, R>{};
    for (var element in keys) {
      returnMap.putIfAbsent(element, () => initVal);
    }

    return returnMap;
  }

  static response.Colors? colorFromString(String color) {
    switch (color) {
      case 'W':
        return response.Colors.White;
      case 'U':
        return response.Colors.Blue;
      case 'B':
        return response.Colors.Black;
      case 'R':
        return response.Colors.Red;
      case 'G':
        return response.Colors.Green;
      case 'C':
        return response.Colors.Colorless;
      default:
        return null;
    }
  }

  static String getFormattedDate(String rawDate) {
    var dateTime = DateTime(2000);
    try {
      dateTime = DateTime.parse(rawDate);
    } on Exception {
      Logger().e('Invalid datetime: $rawDate');
    }

    return '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}';
  }
}

class MtgSymbolUtil {
  MtgSymbolUtil({List<MtgSymbol>? symbols})
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        symbols = symbols ?? <MtgSymbol>[];

  final ApiServiceRepository _apiRepository;
  final List<MtgSymbol> symbols;

  Future<void> initData() async {
    try {
      final response = await _apiRepository.getSymbols();
      if (response.data != null) {
        symbols.addAll(response.data!.toList());
      } else {
        throw Exception('No symbols data');
      }
    } on Exception catch (err) {
      Logger().e(err);
    }
  }

  List<String> getSymbolsUrls(String symbols) {
    final stringSymbols = symbols.replaceAll('}', '').split('{')..removeAt(0);
    final manaUrls = stringSymbols
        .map((stringSymbol) =>
            this
                .symbols
                .firstWhere((symbolObject) =>
                    symbolObject.symbol?.compareTo('{$stringSymbol}') == 0)
                .svgUri ??
            emptyString)
        .toList();
    return manaUrls;
  }
}
