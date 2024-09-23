import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/widgets/cached_image.dart';
import 'package:rick_and_morty/widgets/character_status.dart';
import 'package:rick_and_morty/widgets/details_text.dart';

class CharacterDetails extends StatelessWidget {
  final CharacterEntity character;
  const CharacterDetails({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Character'),
          centerTitle: true,
          backgroundColor: ColorsConstants.pinkColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                character.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorsConstants.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              CachedImage(url: character.image, width: 170, height: 170),
              const SizedBox(
                height: 20,
              ),
              CharacterStatus(
                status: character.status,
                isDetailsScreen: true,
              ),
              DetailsText(title: 'Gender', characterInfo: character.gender),
              DetailsText(
                  title: 'Last Known Location:',
                  characterInfo: character.location.name),
              DetailsText(
                  title: 'Origin', characterInfo: character.origin.name),
              DetailsText(
                  title: 'Episodes:',
                  characterInfo: character.episode.length.toString()),
              DetailsText(
                  title: 'Was Created:', characterInfo: character.created),
            ],
          ),
        ));
  }
}
