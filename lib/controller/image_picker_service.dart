import 'dart:io';
import 'dart:convert'; // For converting the image to Base64
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImagePickerService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final ImagePicker _picker = ImagePicker();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Select an image from the gallery
  static Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Convert the image to Base64
  static Future<String?> convertImageToBase64(File? imageFile) async {
    if (imageFile == null) return null;
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      // ignore: avoid_print
      print("Error converting image to Base64: $e");
      return null;
    }
  }

  // Store the image directly in Firestore (for the logged-in user)
  static Future<void> uploadImageToFirestore(File? imageFile) async {
    User? user = _auth.currentUser;
    if (user == null) {
      print("No user is logged in. Please log in first.");
      return; // Return if no user is logged in
    }

    try {
      String? base64Image = await convertImageToBase64(imageFile);

      if (base64Image != null) {
        // Save image in the user's specific document, overwriting if it exists
        await _firestore.collection('user_images').doc(user.uid).set({
          'image_base64': base64Image,
          'uploaded_at': DateTime.now().toIso8601String(),
        });
        print("Image successfully stored for user ${user.uid}.");
      } else {
        print("Failed to convert image to Base64.");
      }
    } catch (e) {
      print("Error uploading image to Firestore: $e");
    }
  }

  // Get the image from Firestore (for the logged-in user)
  static Future<String?> getImageFromFirestore() async {
    User? user = _auth.currentUser;
    if (user == null) {
      print("No user is logged in. Please log in first.");
      return null; // Return if no user is logged in
    }

    try {
      DocumentSnapshot doc = await _firestore.collection('user_images').doc(user.uid).get();
      if (doc.exists) {
        return doc['image_base64'] as String?;
      } else {
        print("No image found for user ${user.uid}.");
      }
    } catch (e) {
      print("Error fetching image from Firestore: $e");
    }
    return null;
  }
}
