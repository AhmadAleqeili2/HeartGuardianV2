import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<bool> addNotification(String message) async {
  try {
    final notificationData = {
      'message': message,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
    };
    final User? user = FirebaseAuth.instance.currentUser;
    
if(user!=null) {
  await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .collection('user_notifications')
        .add(notificationData);
}

        return true;
  } catch (e) {
return false;
  }
}
