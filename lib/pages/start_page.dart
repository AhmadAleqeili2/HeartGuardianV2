import 'package:app/function/push.dart';
import 'package:app/pages/contact_us.dart';
import 'package:app/pages/detection.dart';
import 'package:app/widgets/text_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart'; 
import 'feedback_page.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 200, 209),
        title: Text(
          'Home'.tr(), 
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)), 
        ),
      ),
      drawer: const CustomDrawer(), 
      body: SingleChildScrollView( 
        child: Column(
          children: [
            const SizedBox(height: 16), 
            Center( 
              child: Image.asset(
                'asset/Image/robut.png', 
                width: 170,
                height: 170,
              ),
            ),
            const SizedBox(height: 20), 
            Text(
              "Let's start".tr(), 
              style: const TextStyle(fontSize: 40), 
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipOval( 
                child: Material(
                  color: const Color.fromARGB(0, 255, 255, 255), 
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Detection()));
                    },
                    child: SizedBox(
                      width: 200, 
                      height: 200, 
                      child: Image.asset(
                        'asset/Image/button.png', 
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 200), 
    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                if (user != null) ...[
                CustomTextButton(
                  label: "Feedback".tr(), 
                  onPressed: () { navigateTo(context, const FeedbackPage()); },
                )],
                CustomTextButton(
                  label: "Contact Us".tr(), 
                  onPressed: () { navigateTo(context, const ContactUsPage()); },
                ),
              ],
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
