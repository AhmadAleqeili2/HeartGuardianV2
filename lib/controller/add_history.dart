import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<bool> addHistory(bool result) async {
  final Map<String, String> history;
  try {
     if(result){history = {
      'message': 
      'The results of the examination indicate a possibility of having heart disease. Please consult a doctor as soon as possible.\n',
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      'result':'There is a disease'
      };}
      else{
     history = {
      'message': 'Your heart health appears to be good\nConsult your doctor for further evaluation\n',
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      'result':'Potential Issues:\n  No significant risk factors detected\n'};}
    final User? user = FirebaseAuth.instance.currentUser;
if(user != null) {
  await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .collection('user_history')
        .add(history);
}

        return true;
  } catch (e) {
return false;
  }
}
