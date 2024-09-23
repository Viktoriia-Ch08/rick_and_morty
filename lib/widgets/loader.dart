import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsConstants.pinkColor,
      ),
    );
  }
}
