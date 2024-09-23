import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/screens/character_details.dart';
import 'package:rick_and_morty/widgets/cached_image.dart';
import 'package:rick_and_morty/widgets/character_status.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  const CharacterCard({super.key, required this.character});



  void _openCharacterDetails(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => CharacterDetails(character: character)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openCharacterDetails(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorsConstants.lightPurpleColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedImage(url: character.image, width: 120, height: 120),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  character.species,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsConstants.greyColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                CharacterStatus(
                  status: character.status,
                ),
                
              ],
            ))
          ],
        ),
      ),
    );
  }
}
