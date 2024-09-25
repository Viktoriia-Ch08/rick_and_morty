import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/character.dart';
import 'package:http/http.dart' as http;

abstract class CharactersRemoteSource {
  Future<List<Character>> getAllCharacters(int page);
  Future<List<Character>> searchCharacter(String query, int page);
}

class CharactersRemoteSourceImpl implements CharactersRemoteSource {
  final http.Client client;

  CharactersRemoteSourceImpl({required this.client});

  @override
  Future<List<Character>> getAllCharacters(int page) => _getCharacterFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<Character>> searchCharacter(String query, int page) =>
      _getCharacterFromUrl(
          'https://rickandmortyapi.com/api/character/?name=$query&page=$page');

  Future<List<Character>> _getCharacterFromUrl(String url) async {
    final parsedUrl = Uri.parse(url);
    final contentType = {'Content-Type': 'application/json'};
    final res = await client.get(parsedUrl, headers: contentType);
    final data = json.decode(res.body);

    if (res.statusCode == 200) {
      return (data['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
