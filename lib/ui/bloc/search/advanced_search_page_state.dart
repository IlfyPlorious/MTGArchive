part of 'advanced_search_page_cubit.dart';

class AdvancedSearchPageState extends Equatable {
  AdvancedSearchPageState(
      {this.page = 1,
      this.searchResultOrder,
      this.status = Status.initial,
      this.exception,
      this.colorSelection,
      List<ColorIdentities>? colors,
      this.typeSelection = emptyString,
      List<String>? types,
      this.text,
      this.power,
      this.toughness,
      this.loyalty,
      this.raritySelection = emptyString,
      List<String>? rarities,
      this.blocksSelection = emptyString,
      List<String>? blocks,
      this.setsSelection = emptyString,
      List<String>? sets,
      this.formatsSelection = emptyString,
      List<String>? formats,
      this.year,
      Map<String, dynamic>? matchAll})
      : colors = colors ?? <ColorIdentities>[],
        types = types ?? <String>[],
        rarities = rarities ?? <String>[],
        blocks = blocks ?? <String>[],
        sets = sets ?? <String>[],
        formats = formats ?? <String>[],
        matchAll = matchAll ??
            <String, dynamic>{
              'types': false,
              'colors': false,
              'rarities': false,
              'blocks': false,
              'sets': false,
              'formats': false,
              'power': '=',
              'toughness': '=',
              'loyalty': '=',
              'year': '=',
            };

  final int page;
  final SearchOrder? searchResultOrder;
  final Status status;
  final Exception? exception;

  final ColorIdentities? colorSelection;
  final List<ColorIdentities> colors;
  final String typeSelection;
  final List<String> types;
  final String? text;
  final String? power;
  final String? toughness;
  final String? loyalty;
  final String raritySelection;
  final List<String> rarities;
  final String blocksSelection;
  final List<String> blocks;
  final String setsSelection;
  final List<String> sets;
  final String formatsSelection;
  final List<String> formats;
  final String? year;
  final Map<String, dynamic> matchAll;

  AdvancedSearchPageState copyWith({
    int? page,
    SearchOrder? searchResultOrder,
    Status? status,
    Exception? exception,
    ColorIdentities? colorSelection,
    List<ColorIdentities>? colors,
    String? typeSelection,
    List<String>? types,
    String? text,
    String? power,
    String? toughness,
    String? loyalty,
    String? raritySelection,
    List<String>? rarities,
    String? blocksSelection,
    List<String>? blocks,
    String? setsSelection,
    List<String>? sets,
    String? formatsSelection,
    List<String>? formats,
    String? year,
    Map<String, dynamic>? matchAll,
  }) {
    return AdvancedSearchPageState(
        page: page ?? this.page,
        searchResultOrder: searchResultOrder ?? this.searchResultOrder,
        status: status ?? this.status,
        exception: exception ?? this.exception,
        colorSelection: colorSelection ?? this.colorSelection,
        colors: colors ?? this.colors,
        typeSelection: typeSelection ?? this.typeSelection,
        types: types ?? this.types,
        text: text ?? this.text,
        power: power ?? this.power,
        toughness: toughness ?? this.toughness,
        loyalty: loyalty ?? this.loyalty,
        raritySelection: raritySelection ?? this.raritySelection,
        rarities: rarities ?? this.rarities,
        blocksSelection: blocksSelection ?? this.blocksSelection,
        blocks: blocks ?? this.blocks,
        setsSelection: setsSelection ?? this.setsSelection,
        sets: sets ?? this.sets,
        formatsSelection: formatsSelection ?? this.formatsSelection,
        formats: formats ?? this.formats,
        year: year ?? this.year,
        matchAll: matchAll ?? this.matchAll);
  }

  @override
  String toString() {
    return '$page, $searchResultOrder, $status, $exception, $colorSelection, $colors, $types,'
        '$text, $power, $toughness, $loyalty, $rarities, $blocks, $sets,'
        '$formats, $year, $matchAll';
  }

  @override
  List<Object?> get props => [
        status,
        page,
        colors,
        typeSelection,
        types,
        raritySelection,
        rarities,
        text,
        power,
        toughness,
        loyalty,
        blocksSelection,
        blocks,
        setsSelection,
        sets,
        formatsSelection,
        formats,
        year,
      ];
}
