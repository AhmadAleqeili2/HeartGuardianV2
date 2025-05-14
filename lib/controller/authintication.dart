
import 'package:app/models/message_model.dart';
import 'package:app/models/sign_in_model.dart';
import 'package:app/models/sign_up_model.dart';
import 'package:app/services/auth_service.dart';
import 'package:dartz/dartz.dart';

class AuthinticationController {
final AuthService authService = AuthService();



// **********Register************
Future<Either<MessageModel, SignUpModel>> register( registerRequste) async {
return authService.register(registerRequste);
}

// **********LogIn************
Future<Either<MessageModel, SignInModel>> login(loginRequste){
 return authService.login(loginRequste);
}

 Future<Either<MessageModel, MessageModel>> updatePassword(String text) {
  return authService.updatePassword(text);
 }

 Future<Either<MessageModel, MessageModel>>  forgotPassword(String text) {
  return authService.forgotPassword(text);

 }

  Future<Either<MessageModel, MessageModel>> resetPasswordRequest(Map<String, String> resetPasswdRequest) {

  return authService.resetPasswordRequest(resetPasswdRequest);
  }


  


}