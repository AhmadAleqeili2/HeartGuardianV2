import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',style:TextStyle(color: Color.fromARGB(255, 255, 255, 255)),).tr(),
        backgroundColor: const Color.fromARGB(255, 76, 200, 209), 
      ),
     
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).tr(),
              const SizedBox(height: 20),
              const Text(
                "Welcome to 'HeartDiagnosis,' your trusted companion in heart health management. "
                "At HeartDiagnosis, we're dedicated to revolutionizing the way individuals monitor "
                "and understand their heart health.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ).tr(),
              const SizedBox(height: 20),
              const Text(
                "Our team comprises passionate experts in cardiology, data science, and software "
                "engineering, united by a common goal: to provide accurate, reliable, and accessible "
                "heart disease diagnosis through innovative technology.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ).tr(),
              const SizedBox(height: 20),
              const Text(
                "Using advanced machine learning algorithms and real-world medical data, we've "
                "developed an intuitive and user-friendly app that empowers users to assess their "
                "heart health with precision and ease. From detecting potential risk factors to providing "
                "personalized recommendations, HeartDiagnosis is your partner in proactive heart care.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ).tr(),
              const SizedBox(height: 30),
              Image.asset(
                'asset/Image/about_us_heart.png', 
                height: 100,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
