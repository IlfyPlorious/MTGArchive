import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/apiservice/apiservice.dart';
import 'package:playground/network/apiservice/scryfall_service.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/requestmodels/cardsrequest.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/requestmodels/setsrequest.dart';
import 'package:playground/network/responsemodels/autocomplete.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/formats.dart';
import 'package:playground/network/responsemodels/scryfall/mtg_symbol.dart';
import 'package:playground/network/responsemodels/scryfall/rulings_response.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/network/responsemodels/sets.dart';

abstract class ApiServiceRepository {
  Future<CardsResponse> getCards(CardsRequest cardsRequest);

  Future<SetsResponse> getSets(SetsRequest setsRequest);

  Future<SingleCardResponse> getCardById(String id);

  Future<FormatsResponse> getFormats();

  Future<AutocompleteResponse> getAutocompleteSuggestions(String query);

  Future<SearchResponse> getSearchedCards(SearchRequest searchRequest);

  Future<ScryfallCard> getCardByName(String name);

  Future<ScryfallCard> getRandomCard();

  Future<ScryfallCard> getScryfallCardById(String multiverseId);

  Future<ScryfallRulingResponse> getRulings(String rulingsUri);

  Future<MtgSymbolsResponse> getSymbols();
}

class ApiServiceRepositoryImpl implements ApiServiceRepository {
  ApiServiceRepositoryImpl(
      {required this.client, required this.scryfallClient});

  ApiService client;
  ScryfallApiService scryfallClient;

  @override
  Future<CardsResponse> getCards(CardsRequest cardsRequest) async {
    try {
      return await client.getCards(cardsRequest.toJson());
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ServerErrorException(
          err.response?.statusMessage, err.response?.statusCode);
    }
  }

  @override
  Future<SetsResponse> getSets(SetsRequest setsRequest) async {
    try {
      return await client.getSets(setsRequest.toJson());
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ServerErrorException(
          err.response?.statusMessage, err.response?.statusCode);
    }
  }

  @override
  Future<SingleCardResponse> getCardById(String id) async {
    try {
      return await client.getCardById(id);
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ServerErrorException(
          err.response?.statusMessage, err.response?.statusCode);
    }
  }

  @override
  Future<FormatsResponse> getFormats() async {
    try {
      return await client.getFormats();
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ServerErrorException(
          err.response?.statusMessage, err.response?.statusCode);
    }
  }

  @override
  Future<AutocompleteResponse> getAutocompleteSuggestions(String query) async {
    try {
      return await scryfallClient.getAutocompleteSuggestions(query);
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<SearchResponse> getSearchedCards(SearchRequest searchRequest) async {
    try {
      return await scryfallClient.getSearchedCards(searchRequest.toJson());
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<ScryfallCard> getRandomCard() async {
    try {
      return await scryfallClient.getRandomCard();
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<ScryfallCard> getCardByName(String name) async {
    try {
      return await scryfallClient.getCardByName(name);
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<ScryfallCard> getScryfallCardById(String cardId) async {
    try {
      return await scryfallClient.getScryfallCardById(cardId);
    } on DioError catch (err) {
      Logger().e('${err.response} with id: $cardId');
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<ScryfallRulingResponse> getRulings(String rulingsUri) async {
    try {
      return await scryfallClient.getRulings(rulingsUri);
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    }
  }

  @override
  Future<MtgSymbolsResponse> getSymbols() async {
    try {
      return await scryfallClient.getSymbolsFromDb();
    } on DioError catch (err) {
      Logger().e(err.response);
      throw ScryfallError(response: err.response);
    } on Error catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }
}
