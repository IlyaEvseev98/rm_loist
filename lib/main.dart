import 'package:flutter/material.dart';
import 'package:rm_list/Widgets/client_provider.dart';
import 'package:rm_list/network/dio_logger.dart';
import 'package:rm_list/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rm_list/screens/characters_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();
  addLoggerToDio(dio);
  runApp(
    MaterialApp(
      theme: theme,
      home: ClientProvider(client: RestClient(dio), child: CharactersScreen()),
    ),
  );
}
