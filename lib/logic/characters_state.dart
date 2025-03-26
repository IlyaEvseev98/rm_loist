part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersError extends CharactersState {}

final class CharactersData extends CharactersState {
  final Info info;
  final List<Character> character;

  CharactersData({required this.info, required this.character});
}
