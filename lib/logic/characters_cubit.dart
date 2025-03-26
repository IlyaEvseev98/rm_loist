import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_list/models/character.dart';
import 'package:rm_list/models/characters_response.dart';

import '../network/rest_client.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final RestClient client;

  CharactersCubit({required this.client}) : super(CharactersInitial());

  void getCharacters() async {
    emit(CharactersLoading());

    try {
      final response = await client.getCharacters();
      emit(CharactersData(info: response.info, character: response.results));
    } on Exception {
      emit(CharactersError());
    }
  }
}
