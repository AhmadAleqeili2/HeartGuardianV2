import 'package:app/core/api/dio_consumer.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/sign_in_model.dart';
import 'package:app/models/sign_up_model.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
class AuthService {
     final UserRepository userRepository =UserRepository(api: DioConsumer(dio: Dio()));






// **********Register************
  Future<Either<MessageModel, SignUpModel>> register( registerRequste) async {
    final response =
     await userRepository.signUp(registerRequste);
   return response;
    }
// **********LogIn************
  Future<Either<MessageModel, SignInModel>> login(logInRequste) async {
    final response = await userRepository.signIn(
      logInRequste
    );
    return response;
    }

  Future<Either<MessageModel, MessageModel>> updatePassword(String text) {
    return userRepository.updatePassword(text);
  }

  Future<Either<MessageModel, MessageModel>> forgotPassword(String text) {
    return userRepository.forgotPassword(text);
  }

  Future<Either<MessageModel, MessageModel>> resetPasswordRequest(Map<String, String> resetPasswdRequest) {
    return userRepository.resetPasswordRequest(resetPasswdRequest);
  }
}