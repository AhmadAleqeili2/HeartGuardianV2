import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us',style: TextStyle(color: Colors.white),).tr(),
        backgroundColor: const Color(0xFF52C7C7),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "We're here to assist you! Whether you have questions about our app, need technical support, or want to share feedback, we're just a message away.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ).tr(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), 
                  borderRadius: BorderRadius.circular(5),
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ).tr(),
                    SizedBox(height: 10),
                    Text('Email: support@heartdiagnosis.com').tr(),
                    Text('Phone: +123-456-7890').tr(),
                    Text('Hours: Monday to Friday, 9:00 AM - 5:00 PM (EST)').tr(),
                  ],
                ),
              ),
              const SizedBox(height: 20), 
              const Text(
                'Social Media:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ).tr(),
              const SizedBox(height: 10),
              const Text('Follow us on Twitter: @HeartDiagnosis').tr(),
              const Text('Like us on Facebook: /HeartDiagnosis').tr(),
            ],
          ),
        ),
      ),
    );
  }
}
