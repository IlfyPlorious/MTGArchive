import 'package:dio/dio.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/formats.dart';
import 'package:playground/network/responsemodels/sets.dart';
import 'package:retrofit/retrofit.dart';
import 'package:playground/utils/constants.dart';

part 'apiservice.g.dart';

@RestApi(baseUrl: NetworkInfo.apiUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/cards")
  Future<CardsResponse> getCards(@Queries() Map<String, dynamic> queries);

  @GET("/sets")
  Future<SetsResponse> getSets(@Queries() Map<String, dynamic> queries);

  @GET("/cards/{id}")
  Future<SingleCardResponse> getCardById(@Path("id") String id);

  @GET("/formats")
  Future<FormatsResponse> getFormats();
}
