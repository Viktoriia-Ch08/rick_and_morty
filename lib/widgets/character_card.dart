import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';
import 'package:rick_and_morty/widgets/cached_image.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  const CharacterCard({super.key, required this.character});

  Color _statusColor(String status) {
    switch (status) {
      case 'Alive':
        return Colors.green;
      case 'Dead':
        return Colors.red;
      case 'unknown':
        return Colors.lightBlue;
      default:
        return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsConstants.greyColor),
                      borderRadius: BorderRadius.circular(15),
                      color: _statusColor(character.status),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      character.status,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Last known location:',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorsConstants.greyColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                character.location.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
