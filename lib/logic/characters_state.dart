part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersFirstLoad extends CharactersState {}

final class CharactersError extends CharactersState {
  final String message;

  CharactersError(this.message);
}

final class CharactersData extends CharactersState {
  final bool hasMore;
  final List<Character> character;

  CharactersData({required this.character, required this.hasMore});
}
