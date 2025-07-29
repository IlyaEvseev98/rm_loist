import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rm_list/Widgets/characters_card.dart';
import 'package:rm_list/logic/characters_cubit.dart';

import '../Widgets/client_provider.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final CharactersCubit charactersCubit;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        final state = charactersCubit.state;

        if (state is! CharactersFirstLoad &&
            state is CharactersData &&
            state.hasMore) {
          charactersCubit.getCharacters();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    charactersCubit = CharactersCubit(
      client: ClientProvider.of(context).client,
    );
    charactersCubit.getCharacters();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>.value(
      value: charactersCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rick & Morty',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.sort_outlined)),
          ],
        ),
        body: BlocListener<CharactersCubit, CharactersState>(
          listener: (context, state) {
            if (state is CharactersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
              if (state is CharactersFirstLoad) {
                return SizedBox(
                  child: Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.pacman,
                      colors: [Theme.of(context).colorScheme.primary],
                    ),
                  ),
                );
              }

              if (state is CharactersData) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: state.character.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.character.length) {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: LoadingIndicator(
                            indicatorType: Indicator.pacman,
                            colors: [Theme.of(context).colorScheme.primary],
                          ),
                        ),
                      );
                    }
                    return CharactersCard(character: state.character[index]);
                  },
                  key: PageStorageKey<String>('charactersList'),
                );
              }
              return Center(child: Text('Нет данных для отображения'));
            },
          ),
        ),
      ),
    );
  }
}
