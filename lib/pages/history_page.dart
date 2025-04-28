import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title:  Text(
          'Heart Disease History'.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: user == null
          ?  Center(child: Text('Please log in to view your history.').tr())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notifications')
                  .doc(user.uid)
                  .collection('user_history')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return  Center(
                    child: Text('Error loading history records.').tr(),
                  );
                }

                if (snapshot.data?.docs.isEmpty ?? true) {
                  return  Center(
                    child: Text('No history records available.').tr(),
                  );
                }

                final historyRecords = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: historyRecords.length,
                  itemBuilder: (context, index) {
                    final record = historyRecords[index];
                    final date = record['date'];
                    final diagnosis = record['message'];
                    final result = record['result'];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(diagnosis).tr(),
                        subtitle: Text('${'Date'.tr()}:\n$date\n${result.toString().tr()}'),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
