import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters Gallery'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, i) => ListTile(
                  title: Text('Smth'),
                )),
      ),
    );
  }
}
