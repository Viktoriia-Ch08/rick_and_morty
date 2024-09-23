import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/domain/usecases/fetch_characters.dart';
import 'package:rick_and_morty/feature/presentation/bloc/cubit/fetch_characters_state.dart';

class FetchCharactersCubit extends Cubit<FetchCharactersState> {
  final FetchCharacters fetchCharacters;

  FetchCharactersCubit({required this.fetchCharacters})
      : super(EmptyCharacters());

  int page = 1;

  load() async {
    if (state is LoadingCharacters) return;

    var oldCharacters = <CharacterEntity>[];

    if (state is LoadedCharacters) {
      oldCharacters = (state as LoadedCharacters).characters;
    }

    emit(LoadingCharacters(
        oldCharacters: oldCharacters, isFirstFetch: page == 1));
    final failureOrCharacters =
        await fetchCharacters(CharactersPageParam(page: page));

    failureOrCharacters.fold(
        (failure) => emit(ErrorFetchCharacters(message: _mapFailure(failure))),
        (characters) {
      page += 1;
      final allCharacters = (state as LoadingCharacters).oldCharacters;
     
      allCharacters.addAll(characters);
      
      emit(LoadedCharacters(characters: allCharacters));
    });
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
