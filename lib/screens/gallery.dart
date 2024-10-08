import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors_constants.dart';
import 'package:rick_and_morty/screens/custom_search_delegate.dart';
import 'package:rick_and_morty/widgets/gallery_list.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters Gallery'),
        centerTitle: true,
        backgroundColor: ColorsConstants.pinkColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(20),
        child: const GalleryList(),
      ),
    );
  }
}
