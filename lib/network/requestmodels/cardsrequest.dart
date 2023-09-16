import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/utils/constants.dart';
import 'package:playground/utils/utils.dart';

class CardsRequest {
  String? name;
  double? cmc;
  List<String>? colorIdentity;
  List<String>? types;
  String? rarity;
  String? setCode;
  int page;
  int pageSize;
  List<Legality>? legalities;
  bool? random;

  CardsRequest(
      {this.name,
      this.cmc,
      this.colorIdentity,
      this.types,
      this.rarity,
      this.legalities,
      this.setCode,
      this.page = 1,
      this.pageSize = 50,
      this.random});

  factory CardsRequest.getRequest(Map<String, dynamic> requestJson) =>
      CardsRequest(
          name: requestJson['name'],
          cmc: requestJson['cmc'],
          colorIdentity: requestJson['colorIdentity'],
          types: requestJson['types'],
          rarity: requestJson['rarity'],
          setCode: requestJson['set'],
          legalities: requestJson['legalities'],
          page: requestJson['page'],
          pageSize: requestJson['pageSize'],
          random: requestJson['random']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'cmc': cmc,
        'colorIdentity': colorIdentity,
        'types': types,
        'rarity': rarity,
        'set': setCode,
        'legalities': legalities,
        'page': page,
        'pageSize': pageSize,
        'random': random
      };
}

class CardsFilters extends Equatable {
  String? name;
  Layouts? layout;
  int? cmc;
  Map<Colors, bool> colors;
  Map<Colors, bool> colorIdentities;
  List<String>? types;
  List<String>? superTypes;
  List<String?> subTypes;
  List<Rarities?> rarities;
  List<String>? setCodes;
  List<String>? setNames;
  String? text;
  List<Legality?> legalities;

  CardsFilters(
      {this.name,
      this.layout,
      this.cmc,
      Map<Colors, bool>? colors,
      Map<Colors, bool>? colorIdentities,
      List<String>? types,
      this.superTypes,
      List<String?>? subTypes,
      List<Rarities?>? rarities,
      this.setCodes,
      this.setNames,
      this.text,
      List<Legality?>? legalities})
      : colors = colors ??
            {
              Colors.White: true,
              Colors.Blue: true,
              Colors.Black: true,
              Colors.Red: true,
              Colors.Green: true,
              Colors.Colorless: true,
            },
        colorIdentities = colorIdentities ??
            {
              Colors.White: true,
              Colors.Blue: true,
              Colors.Black: true,
              Colors.Red: true,
              Colors.Green: true,
              Colors.Colorless: true,
            },
        types = types ?? <String>[],
        subTypes = subTypes ?? <String>[],
        rarities = rarities ?? <Rarities>[],
        legalities = legalities ?? <Legality>[];

  @override
  String toString() {
    return 'cmc: $cmc; layout: $layout';
  }

  bool? doesHaveColors(List<Colors?>? colors) {
    bool hasColors = true;
    if (colors == null) return null;
    for (var element in colors) {
      if (element != null) {
        hasColors = hasColors && (this.colors[element] ?? false);
      } else {
        hasColors = false;
      }
    }

    return hasColors;
  }

  bool? doesHaveColorIdentities(List<Colors?>? colors) {
    bool hasColors = true;
    if (colors == null) return null;
    for (var element in colors) {
      if (element != null) {
        hasColors = hasColors && (colorIdentities[element] ?? false);
      } else {
        hasColors = false;
      }
    }

    return hasColors;
  }

  @override
  List<Object?> get props => [
        name,
        layout,
        cmc,
        colors,
        colorIdentities,
        types,
        superTypes,
        subTypes,
        rarities,
        setCodes,
        setNames,
        text,
        legalities
      ];
}


