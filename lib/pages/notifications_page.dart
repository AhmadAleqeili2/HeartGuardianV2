import 'package:app/colors.dart';
import 'package:app/widgets/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',style: TextStyle(color: Colors.white),).tr(),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .doc(user?.uid)
            .collection('user_notifications')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return  Center(
              child: Text(
                'Error loading notifications.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ).tr(),
            );
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            return  Center(
              child: Text(
                'No notifications.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ).tr(),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final message = notification['message'];
              final dateString = notification['date'];
              final date = DateTime.parse(dateString);
              final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(date);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.teal,
                    size: 30,
                  ),
                  title: Text(
                    message.toString().tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    dialog(context, formattedDate, Colors.teal, message.toString().tr(), Colors.black);
                    
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
