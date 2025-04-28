import 'package:app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  // Fetch user data
  Future<Map<String, dynamic>> _fetchUserData(String userId) async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return document.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  // Fetch user history
  Future<Map<String, dynamic>> _fetchUserHistory(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .doc(userId)
          .collection('user_history')
          .orderBy('date', descending: true)
          .limit(1) // Fetch latest checkup
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data() as Map<String, dynamic>;
      } else {
        return {'message': 'No history found', 'date': 'N/A', 'result': 'N/A'};
      }
    } catch (e) {
      throw Exception("Error fetching user history: $e");
    }
  }

  // Fetch user notifications
  Future<Map<String, dynamic>> _fetchUserNotifications(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .doc(userId)
          .collection('user_notifications')
          .orderBy('date', descending: true)
          .limit(1) // Fetch latest notification
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data() as Map<String, dynamic>;
      } else {
        return {'message': 'No notifications found', 'date': 'N/A'};
      }
    } catch (e) {
      throw Exception("Error fetching notifications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract the current user ID from FirebaseAuth
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Account Information".tr(),style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(child: Text("No user signed in").tr()),
      );
    }

    String userId = user.uid; // Extract user ID

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Information",style: TextStyle(color: Colors.white)).tr(),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Future.wait([
          _fetchUserData(userId),
          _fetchUserHistory(userId),
          _fetchUserNotifications(userId)
        ]).then((List<Map<String, dynamic>> results) {
          return {
            'userData': results[0],
            'userHistory': results[1],
            'userNotifications': results[2]
          };
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data found"));
          }

          var userData = snapshot.data!['userData'];
          var userHistory = snapshot.data!['userHistory'];
          String firstName = userData['first_name'] ?? 'N/A';
          String lastName = userData['last_name'] ?? 'N/A';
          String email = userData['email'] ?? 'N/A';
          String lastLoginDate = userData['created_at'] != null
              ? DateFormat('yyyy-MM-dd HH:mm:ss').format(userData['created_at'].toDate())
              : 'N/A';
          String lastDiagnDate = userHistory['date'] ?? 'N/A';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Table(
                    border: TableBorder.all(
                      color: primaryColor, 
                      width: 2, 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(150), // Narrow column width
                      1: FixedColumnWidth(180), 
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [
                          _buildTableCell("First Name".tr(), true),
                          _buildTableCell(firstName, false),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [
                          _buildTableCell("Last Name".tr(), true),
                          _buildTableCell(lastName, false),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [
                          _buildTableCell("Email".tr(), true),
                          _buildTableCell(email, false),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [
                          _buildTableCell("Last Login Date".tr(), true),
                          _buildTableCell(lastLoginDate, false),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        children: [
                          _buildTableCell("Last Checkup Date".tr(), true),
                          _buildTableCell(lastDiagnDate, false),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableCell(String text, bool isBold) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14, 
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
