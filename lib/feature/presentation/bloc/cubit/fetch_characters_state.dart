import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';

abstract class FetchCharactersState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCharacters extends FetchCharactersState {
  final List<CharacterEntity> oldCharacters;
  final bool isFirstFetch;

  LoadingCharacters({required this.oldCharacters, this.isFirstFetch = false});

  @override
  List<Object> get props => [oldCharacters];
}

class LoadedCharacters extends FetchCharactersState {
  final List<CharacterEntity> characters;

  LoadedCharacters({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ErrorFetchCharacters extends FetchCharactersState {
  final String message;

  ErrorFetchCharacters({required this.message});

  @override
  List<Object> get props => [message];
}

class EmptyCharacters extends FetchCharactersState {
  @override
  List<Object> get props => [];
}
