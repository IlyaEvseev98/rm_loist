import 'package:rm_list/network/rest_client.dart';
import 'package:dio/dio.dart';

void main(List<String> args) {
  final dio = Dio(); // Provide a dio instance
  final client = RestClient(dio);

  client.getCharacters().then((response) => print(response));
}
