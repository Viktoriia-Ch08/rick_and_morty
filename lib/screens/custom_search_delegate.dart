import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/screens/character_details.dart';
import 'package:rick_and_morty/widgets/cached_image.dart';
import 'package:rick_and_morty/widgets/loader.dart';

class CustomSearchDelegate extends SearchDelegate {
  final _suggestions = ['Rick', 'Morty', 'Beth'];

  Widget _showError(String message) {
    return Center(
      child: Text(message),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.close,
        ),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        tooltip: 'Back',
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        separatorBuilder: (context, i) => const Divider(),
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            query = _suggestions[i];
          },
          child: ListTile(
            title: Text(
              _suggestions[i],
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorsConstants.whiteColorTransp),
            ),
          ),
        ),
        itemCount: _suggestions.length,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(SearchCharacterEvent(characterQuery: query));
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is LoadingSearchCharacters) {
        return const Loader();
      }

      if (state is ErrorLoadingSearchCharacters) {
        return _showError('Smth went wrong');
      }

      if (state is EmptySearchCharacters) {
        return _showError('No characters with this name found');
      }

      List<CharacterEntity> characters = [];

      if (state is LoadedSearchCharacters) {
        characters = state.characters;
        if (characters.isEmpty) {
          return _showError('No characters with this name found');
        }
      }

      return ListView.separated(
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CharacterDetails(character: characters[i])));
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Stack(children: [
              CachedImage(
                  url: characters[i].image,
                  width: double.infinity,
                  height: 170),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                          color: ColorsConstants.blackColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Text(
                        characters[i].name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: ColorsConstants.whiteColorTransp,
                            fontWeight: FontWeight.bold),
                      )))
            ]),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: characters.length,
      );
    });
  }
}
