import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecases/usecase.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/domain/repositories/character_rep.dart';

class FetchCharacters
    extends UseCase<List<CharacterEntity>, CharactersPageParam> {
  final CharacterRep characterRep;

  FetchCharacters({required this.characterRep});

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      CharactersPageParam params) async {
    return await characterRep.getAllCharacters(params.page);
  }
}

class CharactersPageParam extends Equatable {
  final int page;

  const CharactersPageParam({required this.page});

  @override
  List<Object> get props => [page];
}
