import 'package:json_annotation/json_annotation.dart';

import 'character.dart';

part 'characters_response.g.dart';

@JsonSerializable()
class CharactersResponse {
  CharactersResponse({required this.info, required this.results});

  Info info;

  @JsonKey(
    name: 'results',
  ) // Указываем, что это поле соответствует 'results' в JSON
  List<Character> results;

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      _$CharactersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  int count;
  int pages;
  String? next; // Сделаем это поле Nullable
  String? prev; // Это поле тоже может быть null

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);

  @override
  String toString() => toJson().toString();
}
