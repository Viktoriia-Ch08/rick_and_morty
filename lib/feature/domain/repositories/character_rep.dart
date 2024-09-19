import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';

abstract class CharacterRep {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(int page);
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(String query);
}
