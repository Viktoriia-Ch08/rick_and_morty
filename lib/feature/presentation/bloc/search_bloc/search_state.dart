import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class EmptySearchCharacters extends SearchState {}

class LoadingSearchCharacters extends SearchState {}

class LoadedSearchCharacters extends SearchState {
  final List<CharacterEntity> characters;

  const LoadedSearchCharacters({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ErrorLoadingSearchCharacters extends SearchState {
  final String message;

  const ErrorLoadingSearchCharacters({required this.message});

  @override
  List<Object> get props => [message];
}
