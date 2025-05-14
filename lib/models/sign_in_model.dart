import 'package:app/core/api/end_ponits.dart';

class SignInModel {
  final bool success;
   String message;

  SignInModel({required this.success, required this.message});

  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
      success: jsonData[ApiKey.code] == 200,
      message: jsonData[ApiKey.message],
    );
  }
}
