import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rm_list/Widgets/chracters_card.dart';
import 'package:rm_list/Widgets/client_provider.dart';
import 'package:rm_list/logic/characters_cubit.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final CharactersCubit charactersCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    charactersCubit = CharactersCubit(
      client: ClientProvider.of(context).client,
    );
    charactersCubit.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>.value(
      value: charactersCubit,
      child: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CharactersCard(character: state.character[index]);
              },
              itemCount: state.character.length,
            );
          } else {
            return LoadingIndicator(indicatorType: Indicator.cubeTransition);
          }
        },
      ),
    );
  }
}
