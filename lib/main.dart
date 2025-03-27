import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rm_list/Widgets/client_provider.dart';
import 'package:rm_list/network/dio_logger.dart';
import 'package:rm_list/network/rest_client.dart';
import 'package:rm_list/screens/characters_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 151, 206, 71),
    primary: const Color.fromARGB(255, 68, 40, 29),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  scaffoldBackgroundColor: const Color.fromARGB(255, 151, 206, 71),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 240, 225, 70),
  ),
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
