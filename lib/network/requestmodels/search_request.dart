import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/utils/constants.dart';

class SearchRequest {
  SearchRequest(
      {this.order,
      required FullTextSearchQuery query,
      this.page,
      required this.matchAll})
      : query = query..matchAll = matchAll;

  SearchOrder? order;
  FullTextSearchQuery query;
  int? page;
  Map<String, dynamic> matchAll;

  factory SearchRequest.getRequest(Map<String, dynamic> requestJson) =>
      SearchRequest(
          order: requestJson['order'],
          query: FullTextSearchQuery.fromString(requestJson['q']),
          matchAll: {}, //todo implement getting match all from string
          page: requestJson['page']);

  Map<String, dynamic> toJson() => {
        'order': order,
        'q': query.getFormattedQuery(),
        'page': page,
      };
}

class FullTextSearchQuery {
  FullTextSearchQuery({
    this.name,
    this.colors,
    this.types,
    this.text,
    this.power,
    this.toughness,
    this.loyalty,
    this.rarities,
    this.blocks,
    this.sets,
    this.formats,
    this.year,
    this.matchAll,
  });

  factory FullTextSearchQuery.fromString(String string) {
    // todo implement mapping
    return FullTextSearchQuery();
  }

  String? name;
  List<ColorIdentities>? colors;
  List<String>? types;
  String? text;
  String? power;
  String? toughness;
  String? loyalty;
  List<String>? rarities;
  List<String>? blocks;
  List<String>? sets;
  List<String>? formats;
  String? year;
  Map<String, dynamic>? matchAll;

  String? getFormattedQuery() {
    String? query;

    if (name != null) {
      if (query != null) {
        query = '($query name:$name)';
      } else {
        query = '(name:$name)';
      }
    }

    if (colors != null && colors?.isNotEmpty == true) {
      if (query != null) {
        matchAll?['colors'] == true
            ? query =
                '($query c=${colors?.map((e) => e.name.toLowerCase()).join('')})'
            : query =
                '($query c:${colors?.map((e) => e.name.toLowerCase()).join('')})';
      } else {
        matchAll?['colors'] == true
            ? query = '(c=${colors?.map((e) => e.name.toLowerCase()).join('')})'
            : query =
                '(c:${colors?.map((e) => e.name.toLowerCase()).join('')})';
      }
    }

    if (types != null && types?.isNotEmpty == true) {
      if (query != null) {
        matchAll?['types'] == true
            ? query = '$query (t=${types?.join(' t=')})'
            : query = '$query (t:${types?.join(' or t:')})';
      } else {
        matchAll?['types'] == true
            ? query = '(t=${types?.join(' t=')})'
            : query = '(t:${types?.join(' or t:')})';
      }
    }

    if (text != null) {
      if (query != null) {
        query = '$query (o:"$text")';
      } else {
        query = '(o:"$text")';
      }
    }

    if (power != null) {
      if (query != null) {
        query = '$query (pow${matchAll?['power']}$power)';
      } else {
        query = '(pow${matchAll?['power']}$power)';
      }
    }

    if (toughness != null) {
      if (query != null) {
        query = '$query (tou${matchAll?['toughness']}$toughness)';
      } else {
        query = '(tou${matchAll?['toughness']}$toughness)';
      }
    }

    if (loyalty != null) {
      if (query != null) {
        query = '$query (loy${matchAll?['loyalty']}$loyalty)';
      } else {
        query = '(loy${matchAll?['loyalty']}$loyalty)';
      }
    }

    if (rarities != null && rarities?.isNotEmpty == true) {
      if (query != null) {
        query = '$query (r:${rarities?.join(' or r:')})';
      } else {
        query = '(r:${rarities?.join(' or r:')})';
      }
    }

    if (blocks != null && blocks?.isNotEmpty == true) {
      if (query != null) {
        matchAll?['blocks'] == true
            ? query = '$query (b=${blocks?.join(' b=')})'
            : query = '$query (b:${blocks?.join(' or b:')})';
      } else {
        matchAll?['blocks'] == true
            ? query = '(b=${blocks?.join(' b=')})'
            : query = '(b:${blocks?.join(' or b:')})';
      }
    }

    if (sets != null && sets?.isNotEmpty == true) {
      if (query != null) {
        matchAll?['sets'] == true
            ? query = '$query (e=${sets?.join(' e=')})'
            : query = '$query (e:${sets?.join(' or e:')})';
      } else {
        matchAll?['sets'] == true
            ? query = '(e=${sets?.join(' e=')})'
            : query = '(e:${sets?.join(' or e:')})';
      }
    }

    if (formats != null && formats?.isNotEmpty == true) {
      if (query != null) {
        matchAll?['formats'] == true
            ? query = '$query (f=${formats?.join(' f=')})'
            : query = '$query (f:${formats?.join(' or f:')})';
      } else {
        matchAll?['formats'] == true
            ? query = '(f=${formats?.join(' f=')})'
            : query = '(f:${formats?.join(' or f:')})';
      }
    }

    if (year != null) {
      if (query != null) {
        query = '$query (year${matchAll?['year']}$year)';
      } else {
        query = '(year${matchAll?['year']}$year)';
      }
    }

    return query == emptyString ? null : query;
  }
}

enum SearchOrder {
  name,
  set,
  released,
  rarity,
  color,
  usd,
  eur,
  cmc,
  power,
  toughness
}
