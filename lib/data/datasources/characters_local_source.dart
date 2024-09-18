import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

const sharedPreferecncesKey = 'CACHED_CHARACTERS';

abstract class CharactersLocalSource {
  Future<List<Character>> getLastCharactersFromCache();
  Future<void> setCharactersToCache(List<Character> characters);
}

class CharactersLocalSourceImpl implements CharactersLocalSource {
  final SharedPreferences sharedPreferences;

  CharactersLocalSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Character>> getLastCharactersFromCache() {
    final jsonCharacters =
        sharedPreferences.getStringList(sharedPreferecncesKey);

    if (jsonCharacters != null && jsonCharacters.isNotEmpty) {
      return Future.value(jsonCharacters
          .map((character) => Character.fromJson(json.decode(character)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setCharactersToCache(List<Character> characters) async {
    final jsonCharacters =
        characters.map((character) => json.encode(character.toJson())).toList();

    sharedPreferences.setStringList(sharedPreferecncesKey, jsonCharacters);

    return Future.value(jsonCharacters);
  }
}
