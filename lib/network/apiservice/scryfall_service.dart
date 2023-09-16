import 'package:dio/dio.dart';
import 'package:playground/network/responsemodels/autocomplete.dart';
import 'package:playground/network/responsemodels/scryfall/mtg_symbol.dart';
import 'package:playground/network/responsemodels/scryfall/rulings_response.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'scryfall_service.g.dart';

@RestApi(baseUrl: NetworkInfo.scryfallApiUrl)
abstract class ScryfallApiService {
  factory ScryfallApiService(Dio dio, {String baseUrl}) = _ScryfallApiService;

  @GET("/cards/autocomplete")
  Future<AutocompleteResponse> getAutocompleteSuggestions(
      @Query('q') String query);

  @GET("/cards/search")
  Future<SearchResponse> getSearchedCards(
      @Queries() Map<String, dynamic> queries);

  @GET("/cards/random")
  Future<ScryfallCard> getRandomCard();

  @GET("/cards/{id}")
  Future<ScryfallCard> getScryfallCardById(@Path("id") String cardId);

  @GET("/cards/named")
  Future<ScryfallCard> getCardByName(@Query('exact') String name);

  @GET("/cards/{id}/rulings")
  Future<ScryfallRulingResponse> getRulings(@Path("id") String cardId);

  @GET("/symbology")
  Future<MtgSymbolsResponse> getSymbolsFromDb();
}
