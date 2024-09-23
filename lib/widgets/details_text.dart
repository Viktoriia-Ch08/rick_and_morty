import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';

class DetailsText extends StatelessWidget {
  final String title;
  final String characterInfo;

  const DetailsText(
      {super.key, required this.title, required this.characterInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: ColorsConstants.whiteColorTransp)),
        Text(characterInfo,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorsConstants.whiteColor)),
      ],
    );
  }
}
