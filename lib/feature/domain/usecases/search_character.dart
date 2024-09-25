import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecases/usecase.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/domain/repositories/character_rep.dart';

class SearchCharacter
    extends UseCase<List<CharacterEntity>, CharacterQueryParam> {
  final CharacterRep characterRep;

  SearchCharacter({required this.characterRep});

  Future<Either<Failure, List<CharacterEntity>>> call(
      CharacterQueryParam params) async {
    return await characterRep.searchCharacter(params.query, params.page);
  }
}

class CharacterQueryParam extends Equatable {
  final String query;
  final int page;

  const CharacterQueryParam({required this.query, required this.page});

  @override
  List<Object> get props => [query];
}
