import 'package:equatable/equatable.dart';

class MtgSymbolsResponse {
  String? object;
  bool? hasMore;
  List<MtgSymbol>? data;

  MtgSymbolsResponse({this.object, this.hasMore, this.data});

  MtgSymbolsResponse.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    hasMore = json['has_more'];
    if (json['data'] != null) {
      data = <MtgSymbol>[];
      json['data'].forEach((v) {
        data!.add(MtgSymbol.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['has_more'] = hasMore;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MtgSymbol extends Equatable {
  String? object;
  String? symbol;
  String? svgUri;
  String? looseVariant;
  String? english;
  bool? transposable;
  bool? representsMana;
  bool? appearsInManaCosts;
  double? manaValue;
  double? cmc;
  bool? funny;
  List<dynamic>? colors;
  List<dynamic>? gathererAlternates;

  MtgSymbol(
      {this.object,
      this.symbol,
      this.svgUri,
      this.looseVariant,
      this.english,
      this.transposable,
      this.representsMana,
      this.appearsInManaCosts,
      this.manaValue,
      this.cmc,
      this.funny,
      this.colors,
      this.gathererAlternates});

  MtgSymbol.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    symbol = json['symbol'];
    svgUri = json['svg_uri'];
    looseVariant = json['loose_variant'];
    english = json['english'];
    transposable = json['transposable'];
    representsMana = json['represents_mana'];
    appearsInManaCosts = json['appears_in_mana_costs'];
    manaValue = json['mana_value'];
    cmc = json['cmc'];
    funny = json['funny'];
    colors = json['colors'];
    gathererAlternates = json['gatherer_alternates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['symbol'] = symbol;
    data['svg_uri'] = svgUri;
    data['loose_variant'] = looseVariant;
    data['english'] = english;
    data['transposable'] = transposable;
    data['represents_mana'] = representsMana;
    data['appears_in_mana_costs'] = appearsInManaCosts;
    data['mana_value'] = manaValue;
    data['cmc'] = cmc;
    data['funny'] = funny;
    data['colors'] = colors;
    data['gatherer_alternates'] = gathererAlternates;
    return data;
  }

  @override
  List<Object?> get props => [symbol, svgUri];
}
