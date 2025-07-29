import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rm_list/Widgets/client_provider.dart';
import 'package:rm_list/network/dio_logger.dart';
import 'package:rm_list/network/rest_client.dart';
import 'package:rm_list/screens/characters_screen.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 20, 58, 21),
    primary: const Color.fromARGB(255, 39, 26, 24),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  scaffoldBackgroundColor: const Color.fromARGB(255, 20, 58, 21),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(128, 240, 225, 70),
  ),
);
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
      darkTheme: darkTheme,
      home: ClientProvider(client: RestClient(dio), child: CharactersScreen()),
    ),
  );
}
