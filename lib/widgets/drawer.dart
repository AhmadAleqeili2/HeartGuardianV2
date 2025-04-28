import 'dart:convert';

import 'package:app/colors.dart';
import 'package:app/controller/image_picker_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/history_page.dart';
import '../pages/about_us_page.dart';
import '../pages/change_password_page.dart';
import '../pages/feedback_page.dart';
import '../pages/notifications_page.dart';
import '../pages/settings_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  static const Color drawerColor = Color.fromARGB(255, 43, 183, 204);
  static const Color headerColor = Color.fromARGB(255, 116, 184, 243);

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  String? bytimage;

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  // Get the image from Firestore and update the UI
  Future<void> _getImage() async {
    String? fetchedImage = await ImagePickerService.getImageFromFirestore();
    setState(() {
      bytimage = fetchedImage; // تحديث حالة الصورة بعد تحميلها
    });
  }

  // Get the user name
  Future<String> _getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        String firstName = userData['first_name'] ?? 'First Name'.tr();
        String lastName = userData['last_name'] ?? 'Last Name'.tr();
        return '$firstName $lastName';
      }
    }
    return 'Guest'.tr();
  }

  // Pick an image from the gallery and upload it
  Future<void> _pickImage() async {
    ImagePickerService.pickImage().then((image) {
      if (image != null) {
        // Convert image to base64 and upload it
        ImagePickerService.convertImageToBase64(image).then((base64Image) {
          if (base64Image != null) {
            ImagePickerService.uploadImageToFirestore(image);
            setState(() {
              // After uploading, update the UI with the new image
              bytimage = base64Image; // Update the image immediately
            });
          }
        });
      }
    });
  }

  // Build the header with user info and image
  Widget buildHeader() {
    return FutureBuilder<String>(
      future: _getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Error fetching user name').tr();
        }

        String userName = snapshot.data ?? 'User Name';

        return Container(
          width: 340,
          height: 180,
          color: const Color.fromARGB(255, 57, 125, 136),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: ClipOval(
                  child: bytimage != null
                      ? Image.memory(
                          base64Decode(bytimage!), // تحويل Base64 إلى صورة
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                        )
                      : Image.asset(
                          'asset/Image/Anonymous.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  // Build menu items in the drawer
  Widget _buildMenuItems(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return ListView(
      children: [
        if (user != null) ...[
          buildDrawerItem(
            context,
            icon: Icons.history,
            text: 'History',
            page: HistoryPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.password,
            text: 'Change Password',
            page: const ChangePasswordPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.feedback,
            text: 'Feedback',
            page: const FeedbackPage(),
          ),
          buildDrawerItem(
            context,
            icon: Icons.notifications,
            text: 'Notifications',
            page: const NotificationsPage(),
          ),
        ],
        buildDrawerItem(
          context,
          icon: Icons.settings,
          text: 'Settings',
          page: const SettingsPage(),
        ),
        buildDrawerItem(
          context,
          icon: Icons.info,
          text: 'About Us',
          page: const AboutUsPage(),
        ),
        buildLogoutItem(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: Column(
          children: [
            buildHeader(),
            Expanded(child: _buildMenuItems(context)),
          ],
        ),
      ),
    );
  }
}
