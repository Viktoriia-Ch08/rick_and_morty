import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';

class CharacterStatus extends StatelessWidget {
  final String status;
  final bool isDetailsScreen;
  const CharacterStatus(
      {super.key, required this.status, this.isDetailsScreen = false});

  Color _statusColor(String status) {
    switch (status) {
      case 'Alive':
        return ColorsConstants.greenColor;
      case 'Dead':
        return ColorsConstants.redColor;
      case 'unknown':
        return ColorsConstants.lightBlueColor;
      default:
        return ColorsConstants.yellowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = isDetailsScreen ? 15 : 10;
    return Row(
      mainAxisAlignment:
          isDetailsScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            border: Border.all(color: ColorsConstants.greyColor),
            borderRadius: BorderRadius.circular(15),
            color: _statusColor(status),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          status,
          style: isDetailsScreen
              ? Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ColorsConstants.whiteColor)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
