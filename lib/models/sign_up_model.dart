import 'package:app/core/api/end_ponits.dart';

class SignUpModel {
  final bool success;
   String message;

  SignUpModel( {required this.success, required this.message});
  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(
      success : jsonData[ApiKey.code] == 200,
      message: jsonData[ApiKey.message],
    );
  }
}
