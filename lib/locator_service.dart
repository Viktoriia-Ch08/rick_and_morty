import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network.dart';
import 'package:rick_and_morty/feature/data/datasources/characters_local_source.dart';
import 'package:rick_and_morty/feature/data/datasources/characters_remote_source.dart';
import 'package:rick_and_morty/feature/data/repositories/characters_repository.dart';
import 'package:rick_and_morty/feature/domain/repositories/character_rep.dart';
import 'package:rick_and_morty/feature/domain/usecases/fetch_characters.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_character.dart';
import 'package:rick_and_morty/feature/presentation/bloc/cubit/fetch_characters_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc Cubit
  sl.registerFactory(() => FetchCharactersCubit(fetchCharacters: sl()));
  sl.registerFactory(() => SearchBloc(searchCharacter: sl()));

  //Usecases
  sl.registerLazySingleton(() => FetchCharacters(characterRep: sl()));
  sl.registerLazySingleton(() => SearchCharacter(characterRep: sl()));

  //Repository, Sources
  sl.registerLazySingleton<CharacterRep>(() => CharactersRepository(
      remoteSource: sl(), localSource: sl(), networkConnection: sl()));

  //? Local Source
  sl.registerLazySingleton<CharactersLocalSource>(
      () => CharactersLocalSourceImpl(sharedPreferences: sl()));

  //? Remote Source
  sl.registerLazySingleton<CharactersRemoteSource>(
      () => CharactersRemoteSourceImpl(client: http.Client()));

  //Core
  sl.registerLazySingleton<NetworkConnection>(
      () => NetworkConnection(connectionChecker: sl()));

  //External
  final sharedPref = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPref);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
