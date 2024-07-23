import 'dart:io';

import 'package:admin_panel/widgets/home_image_container.dart';
import 'package:admin_panel/widgets/text_field_container.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:image_picker/image_picker.dart';

void main(List<String> args) {
  runApp(const AdminPanel());
}

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  File? _image;
  final picker = ImagePicker();
  List<MediaFile> _selectedImages = [];

  final TextEditingController _tourNameController = TextEditingController();
  final TextEditingController _questCountController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  Future getMoreImagesFromGallery() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              
              const Center(
                child: Text(
                  "Home Menu",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImageGallery();
                      },
                      child: HomeImageContainer(image: _image),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFieldContainer(
                            tourNameController: _tourNameController),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldContainer(
                            tourNameController: _questCountController),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldContainer(
                            tourNameController: _totalPriceController),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Tour Detail Screen",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: AnotherCarousel(images: _selectedImages),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        List<MediaFile> _mediaFile =
                            await GalleryPicker.pickMedia(
                                    context: context, singleMedia: false) ??
                                [];
                        setState(() {
                          _selectedImages = _mediaFile;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
