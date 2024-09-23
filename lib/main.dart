import 'dart:io';

import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/widgets/detail_images_container.dart';
import 'package:admin_panel/widgets/home_image_container.dart';
import 'package:admin_panel/widgets/text_field_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  List<File> _images = [];

  final TextEditingController _tourNameController = TextEditingController();
  final TextEditingController _questCountController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _aboutTourController = TextEditingController();
  final TextEditingController _tittleNotificationController =
      TextEditingController();
  final TextEditingController _textNotificationController =
      TextEditingController();

  Future getImagesGallery() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 80,
    );
    setState(
      () {
        if (pickedFiles.isNotEmpty) {
          _images = pickedFiles.map((file) => File(file.path)).toList();
          print("SHEKILLER: $_images");
        } else {
          print("Resim seçilmedi");
        }
      },
    );
  }

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

  Future addFirestore() async {
    final Map<String, dynamic> data = {'tourName': _tourNameController.text};
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('tourInfo').add(data);
  }

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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: getImageGallery,
                      child: HomeImageContainer(image: _image),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        TextFieldContainer(
                          controller: _tourNameController,
                          hintText: "Enter Tour Name",
                          minHeight: 50,
                        ),
                        const SizedBox(height: 10),
                        TextFieldContainer(
                          controller: _questCountController,
                          hintText: "Enter Quest's Count",
                          minHeight: 50,
                        ),
                        const SizedBox(height: 10),
                        TextFieldContainer(
                          controller: _totalPriceController,
                          hintText: "Enter Total Price",
                          minHeight: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: DetailImagesContainer(images: _images),
                          ),
                          Expanded(
                            child: TextFieldContainer(
                              controller: _aboutTourController,
                              hintText: "Edit Text About Tour",
                              minHeight: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: getImagesGallery,
                      child: const Text('CHECK PHOTOS'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addFirestore();
                        });
                      },
                      child: const Text('Send Home & Detail Fields to Backend'),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFieldContainer(
                        controller: _tittleNotificationController,
                        hintText: "Enter Tittle Notification"),
                    const SizedBox(height: 10),
                    TextFieldContainer(
                        controller: _textNotificationController,
                        hintText: "Enter Text Notification"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Send Notification Field to Backend'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
