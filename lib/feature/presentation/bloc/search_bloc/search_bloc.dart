import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_character.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCharacter searchCharacter;

  SearchBloc({required this.searchCharacter}) : super(EmptySearchCharacters()) {
    on<SearchCharacterEvent>((event, emit) =>
        _mapFetchCharactersToState(event.characterQuery, emit));
  }

  Future<void> _mapFetchCharactersToState(
      String query, Emitter<SearchState> emit) async {
    emit(LoadingSearchCharacters());

    final failureOrCharacters =
        await searchCharacter(CharacterQueryParam(query: query));

    failureOrCharacters.fold(
      (failure) =>
          emit(ErrorLoadingSearchCharacters(message: _mapFailure(failure))),
      (character) => emit(LoadedSearchCharacters(characters: character)),
    );
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
