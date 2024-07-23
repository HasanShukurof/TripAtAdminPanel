import 'dart:io';

import 'package:flutter/material.dart';

class HomeImageContainer extends StatelessWidget {
  const HomeImageContainer({
    super.key,
    required File? image,
  }) : _image = image;

  final File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: _image != null
          ? Image.file(
              _image!.absolute,
              fit: BoxFit.contain,
            )
          : const Center(child: Text("Home Page Image")),
    );
  }
}
