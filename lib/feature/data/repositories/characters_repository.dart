import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/platform/network.dart';
import 'package:rick_and_morty/feature/data/datasources/characters_local_source.dart';
import 'package:rick_and_morty/feature/data/datasources/characters_remote_source.dart';
import 'package:rick_and_morty/feature/data/models/character.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/feature/domain/repositories/character_rep.dart';

class CharactersRepository implements CharacterRep {
  final CharactersRemoteSource remoteSource;
  final CharactersLocalSource localSource;
  final NetworkConnection networkConnection;

  CharactersRepository(
      {required this.remoteSource,
      required this.localSource,
      required this.networkConnection});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
      int page) async {
    return _getCharacters(() => remoteSource.getAllCharacters(page));
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(String query) {
    return _getCharacters(() => remoteSource.searchCharacter(query));
  }

  Future<Either<Failure, List<Character>>> _getCharacters(
      Future<List<Character>> Function() getCharacters) async {
    if (await networkConnection.isConnected) {
      try {
        final characters = await getCharacters();
        localSource.setCharactersToCache(characters);
        return Right(characters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacters = await localSource.getLastCharactersFromCache();
        return Right(localCharacters);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
