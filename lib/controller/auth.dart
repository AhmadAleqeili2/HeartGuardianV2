import 'package:app/controller/add_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
/* ---------saveData------------- */
  static Future<bool> saveData(
    UserCredential userCredential,
    String firstName,
    String lastName,
  ) async {
      if (userCredential.user != null) {
        final userId = userCredential.user!.uid;
        await _firestore.collection('users').doc(userId).set({
          'email': userCredential.user?.email,
          'first_name': firstName,
          'last_name': lastName,
          'created_at': Timestamp.now(),


        });
        await addNotification('Created Account successfully');
        return true;  
      }else{return false;}      
      }

/* ---------signInWithGoogle------------- */


  static Future<UserCredential?> signInWithGoogle() async {
    try{ final  googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken ,accessToken: googleAuth?.accessToken);
    return _auth.signInWithCredential(cred);
    
    }catch(e)
    {return null;}
  }

  /* ---------signUpAndSaveData------------- */

  static Future<bool> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(await saveData(userCredential, firstName, lastName)){return true;}else{return false;}

    } catch (e) {
      return false; 
    }
  }
  /* ---------signIn------------- */

  static Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
 await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
await addNotification('Logged in successfully');
return true;
  
  
        
      
    } catch (e) {

      return false; 
    }
  }
}
