import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/characters_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://rickandmortyapi.com/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/character')
  Future<CharactersResponse> getCharacters();
}
