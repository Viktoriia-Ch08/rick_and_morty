import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_character.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCharacter searchCharacter;

  SearchBloc({required this.searchCharacter}) : super(EmptySearchCharacters());

  Stream<SearchState> _mapEventToState(SearchCharacterEvent event) async* {
    yield* _mapFetchCharactersToState(event.characterQuery);
  }

  Stream<SearchState> _mapFetchCharactersToState(String query) async* {
    yield LoadingSearchCharacters();

    final failureOrCharacters =
        await searchCharacter(CharacterQueryParam(query: query));

    failureOrCharacters.fold(
        (failure) =>
            ErrorLoadingSearchCharacters(message: _mapFailure(failure)),
        (character) => LoadedSearchCharacters(characters: character));
  }

  String _mapFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Failure';
    }
  }
}
