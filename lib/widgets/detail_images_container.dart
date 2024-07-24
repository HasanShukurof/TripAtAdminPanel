import 'dart:io';
import 'package:flutter/material.dart';

class DetailImagesContainer extends StatelessWidget {
  const DetailImagesContainer({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: images.isNotEmpty
          ? PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  images[index],
                  fit: BoxFit.contain,
                );
              },
            )
          : const Center(child: Text("Detail Page Images")),
    );
  }
}
