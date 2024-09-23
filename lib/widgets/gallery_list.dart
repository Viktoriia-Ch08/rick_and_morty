import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/presentation/bloc/cubit/fetch_characters_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/cubit/fetch_characters_state.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class GalleryList extends StatelessWidget {
  const GalleryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    List<CharacterEntity> characters = [];
    bool isLoading = false;

    void controlScroll(BuildContext context) {
      scrollController.addListener(() {
        if (scrollController.position.atEdge) {
          if (scrollController.position != 0) {
            context.read<FetchCharactersCubit>().load();
          }
        }
      });
    }

    Widget _loadIndicator() {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorsConstants.pinkColor,
        ),
      );
    }

    return BlocBuilder<FetchCharactersCubit, FetchCharactersState>(
        builder: (context, state) {
      controlScroll(context);
      if (state is LoadingCharacters && state.isFirstFetch) {
        return _loadIndicator();
      }
      if (state is LoadingCharacters) {
        isLoading = true;
        characters = state.oldCharacters;
      }

      if (state is ErrorFetchCharacters) {
        return Center(
          child: Text(
            state.message,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ColorsConstants.redColor),
          ),
        );
      }

      if (state is LoadedCharacters) {
        characters = state.characters;
      }

      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, i) {
            if (i < characters.length) {
              return CharacterCard(character: characters[i]);
            } else {
              Timer(
                  const Duration(milliseconds: 30),
                  () => scrollController
                      .jumpTo(scrollController.position.maxScrollExtent));
              return _loadIndicator();
            }
          },
          separatorBuilder: (context, i) =>
              const Divider(color: ColorsConstants.blackColor),
          itemCount: characters.length + (isLoading ? 1 : 0));
    });
  }
}
