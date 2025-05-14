import 'package:app/core/api/end_ponits.dart';

class UserModel {
  final bool success;
  final String email;
  final String firstname;
  final String lastname;
  final String lastDiagnosis;
  final String lastLogin;
  UserModel({
     this.success = false,
     this.email = 'Gust@gmail.com',
     this.firstname = 'Gust',
     this.lastname = '',
     this.lastDiagnosis = '',
     this.lastLogin = '',    
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
   try {
      return UserModel(
      success: jsonData.isEmpty ? false : true,
      email: jsonData[ApiKey.email],
      firstname: jsonData[ApiKey.firstName],
      lastname: jsonData[ApiKey.lastName],
      lastDiagnosis: jsonData[ApiKey.lastDiagnosis],
       lastLogin:  jsonData[ApiKey.lastLogin],
    );
    } catch (e) {
      return UserModel(
        success: false,);
    }
    
  }
}
