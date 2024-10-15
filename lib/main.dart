import 'dart:io';

import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/home_screen.dart';
import 'package:admin_panel/order_table_screen.dart';
import 'package:admin_panel/widgets/detail_images_container.dart';
import 'package:admin_panel/widgets/home_image_container.dart';
import 'package:admin_panel/widgets/text_field_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          body: const HomeScreen()),
    );
  }
}
