import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_list/models/character.dart';

import '../network/rest_client.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final RestClient client;
  List<Character> allCharacters = [];
  int currentPage = 1;
  bool isLoading = false;

  CharactersCubit({required this.client}) : super(CharactersInitial());

  Future<void> getCharacters() async {
    if (isLoading ||
        (state is CharactersData && !(state as CharactersData).hasMore)) {
      return;
    }

    isLoading = true;

    if (currentPage == 1) {
      emit(CharactersFirstLoad());
    }

    try {
      final newCharacters = await client.fetchCharacters(page: currentPage);

      if (newCharacters.results.isEmpty) {
        emit(CharactersData(character: allCharacters, hasMore: false));
        return;
      }

      allCharacters.addAll(newCharacters.results);
      currentPage++;

      emit(
        CharactersData(
          character: allCharacters,
          hasMore: newCharacters.info.next != null,
        ),
      );
    } catch (e) {
      emit(CharactersError(e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
