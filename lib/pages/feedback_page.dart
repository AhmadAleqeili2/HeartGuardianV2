import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:app/widgets/custom_button.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _hasSubmittedFeedback = false; 

  // Function to check if feedback has already been submitted
  Future<void> _checkFeedbackStatus() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    
    if (userDoc.exists && userDoc.data()?['feedback'] != null) {
      setState(() {
        _hasSubmittedFeedback = true; // If feedback exists
      });
    }
  }

  // Function to submit feedback to Firestore in the 'users' collection
  Future<void> _submitFeedback() async {
    final User? user = _auth.currentUser; // Get the current user
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Please log in to submit feedback".tr())),
      );
      return;
    }

    if (_feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Feedback cannot be empty".tr())),
      );
      return;
    }

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'feedback': _feedbackController.text.trim(), // Add the feedback
        'last_feedback_time': Timestamp.now(), // Time of submitting feedback
      });

      // Show success message
     if (!mounted) return; ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Feedback submitted successfully".tr())),
      );

      // Update state to show a message instead of the text box
      setState(() {
        _hasSubmittedFeedback = true;
      });
      _feedbackController.clear();
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting feedback: $e").tr()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFeedbackStatus(); // Check feedback status on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: const Color.fromARGB(255, 76, 200, 209),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            // If feedback has been submitted, show a message instead of the text box
            if (_hasSubmittedFeedback) ...[
              const Text(
                "You have already submitted your feedback. Thank you for sharing your experience!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ).tr(),
            ] else ...[
              TextField(
                controller: _feedbackController,
                decoration:  InputDecoration(
                  labelText: 'Your Feedback'.tr(),
                  labelStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                maxLines: 5, 
                maxLength: 120, // Maximum text length of 120 characters
              ),

              Padding(
                padding: EdgeInsets.only(left: 8.0), 
                child: Text(
                  "Share Your Experience",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12),
                ).tr(),
              ),

              const SizedBox(height: 20), 

              CustomButton(
                label: "Submit".tr(),
                onPressed: _submitFeedback, // Call the submit function on press
              ),
            ],
          ],
        ),
      ),
    );
  }
}
