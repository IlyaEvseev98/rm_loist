import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'package:rm_list/models/characters_response.dart';

import '../network/rest_client.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  late final RestClient client;
  late final Dio dio;

  CharactersCubit({required this.client, required this.dio})
    : super(CharactersInitial()) {
    changeState();
  }

  void changeState() async {
    client = RestClient(dio);
    emit(CharactersLoading());

    try {
      final response =
          await client.getCharacters(); // Убедитесь, что тип соответствует
      emit(CharactersData(response)); // Передайте полученные данные
    } on Exception {
      emit(CharactersError());
    }
  }
}
