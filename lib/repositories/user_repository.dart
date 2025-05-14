import 'dart:io';

import 'package:app/core/errors/service_exception.dart';
import 'package:app/models/feedback_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/notification_model.dart';
import 'package:app/models/profile_image_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/cache/cache_helper.dart';
import 'package:app/core/api/api_consumer.dart';
import 'package:app/core/api/end_ponits.dart';
import 'package:app/models/sign_in_model.dart';
import 'package:app/models/sign_up_model.dart';
import 'package:app/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<MessageModel, SignInModel>> signIn(logInRequste) async {
    try {
      final Response response = await api.post(
        EndPoint.login,
        data: {
          ApiKey.email: logInRequste['email'],
          ApiKey.password: logInRequste['password'],
        },
      );
      final user = SignInModel.fromJson(response.data);
    if (!user.success) {
      final message = MessageModel(message: user.message);
        return Left(message);
      }
      final decodedToken = JwtDecoder.decode(user.message);
      CacheHelper().saveData(key: ApiKey.token, value: user.message);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken['sub']);
      user.message = "Login Success";
      return Right(user);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, SignUpModel>> signUp(registerRequste) async {
    try {
      Response  response = await api.post(
        EndPoint.register,
        data: {
          ApiKey.firstName: registerRequste['firstname'],
          ApiKey.lastName: registerRequste['lastname'],
          ApiKey.email: registerRequste['email'],
          ApiKey.password: registerRequste['password'],
        },
      );

      final signUPModel = SignUpModel.fromJson(response.data);
      if (!signUPModel.success) {
        final message = MessageModel(message: signUPModel.message);
        return Left(message);
      }
      final decodedToken = JwtDecoder.decode(signUPModel.message);
      CacheHelper().saveData(key: ApiKey.token, value: signUPModel.message);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken['sub']);
      signUPModel.message = "Register Success";
      return Right(signUPModel);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, UserModel>> getUserProfile() async {
    try {
      final Response response = await api.get(
        EndPoint.userprofile
      );
      if(response.statusCode == 200){
        UserModel user =  UserModel.fromJson(response.data);
        return Right(user);
      }
     
      
        final message = MessageModel(message: "Faild to load user profile");
        return Left(message);
      
      
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel,MessageModel>> deleteAccount() async {
    try {
      
      final Response response = await api.delete(
        EndPoint.deleteAccount,
      );
      if(response.statusCode == 200){
        CacheHelper().removeData(key: ApiKey.token);
        MessageModel message = MessageModel();
        message.success = true;
        message.message = "Account deleted successfully";
        return Right(message); 
      }
      return Right(response.data);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, MessageModel>> sentHistory(Map<String, dynamic> history) async {
    try {
      final Response response = await api.post(
        EndPoint.history,
        data: {
          ApiKey.history: history['history'],
          ApiKey.message: history['message'],
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(MessageModel.fromJson(response.data));
      }
      message = MessageModel(success: false, message: "Failed to send history");
      if (!message.success) {
        return Left(message);
      }
      return Right(message);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }

  }

  Future<Either<MessageModel, MessageModel>> sentNotification(String notification) async {
    try {
      final Response response = await api.post(
        EndPoint.notification,
        data: {
          ApiKey.message: notification,
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(MessageModel.fromJson(response.data));
      }
      message = MessageModel(success: false, message: "Failed to send notification");
      if (!message.success) {
        return Left(message);
      }
      return Right(message);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }

  }

  Future<Either<MessageModel, MessageModel>> sentFeedBack(String feedBack) async {
    try {
      final Response response = await api.post(
        EndPoint.feedback,
        data: {
          ApiKey.feedback: feedBack,
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(MessageModel.fromJson(response.data));
      }
      
      message = MessageModel(success: false, message: "Failed to send feedback");
      if (!message.success) {
        return Left(message);
      }
      return Right(message);
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }

  }

  Future<Either<MessageModel, FeedBackModel>> getFeedBack() async {
    try {
      final Response response = await api.get(
        EndPoint.feedback,
      );
     
      if(response.statusCode == 200){
        return Right(FeedBackModel.fromJson(response.data));
      }
       MessageModel message;
      message = MessageModel(success: false, message: "Failed to load feedback");
      
        return Left(message);
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, List<HistoryModel>>> getHistory() async {
    try {
      final Response response = await api.get(
        EndPoint.history,
      );
      
      if(response.statusCode == 200){
        return Right((response.data as List).map((item) => HistoryModel.fromJson(item)).toList());
      }
      MessageModel message;
      if(response.statusCode == 404){
        message = MessageModel(success: false, message: "No history found");}
        else{
      message = MessageModel(success: false, message: "Failed to load history");
    }
        return Left(message);
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, List<NotificationModel>>> getNotification() async {
    try {
      final Response response = await api.get(
        EndPoint.notification,
      );
      
      if(response.statusCode == 200){
        return Right((response.data as List).map((item) => NotificationModel.fromJson(item)).toList());
      }
      MessageModel message;
      if(response.statusCode == 404){
        message = MessageModel(success: false, message: "No notification found");}
        else{
      message = MessageModel(success: false, message: "Failed to load notification");
        }
        return Left(message);
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<bool> feedBackCheck() async {
    try {
      final Response response = await api.get(
        EndPoint.feedback,
      );
      if (response.statusCode == 200) {
        return false;
      }
      return true;
    } on ServiceException {
      return true;
    }
  }

  Future<Either<MessageModel, MessageModel>> updatePassword(String text) async {
    try {
      final Response response = await api.put(
        EndPoint.updatePassword,
        data: {
          ApiKey.newPassword: text,
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(message);
      }
      message = MessageModel(success: false, message: "Failed to update password");
      
        return Left(message);
      
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, MessageModel>> forgotPassword(String text) async {
    try {
      final Response response = await api.post(
        EndPoint.forgotPassword,
        data: {
          ApiKey.email: text,
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(message);
      }
      message = MessageModel(success: false, message: "Your email is not registered");
      
        return Left(message);
      
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, MessageModel>> resetPasswordRequest(Map<String, String> resetPasswdRequest) async {
    try {
      final Response response = await api.put(
        EndPoint.resetPasswordRequest,
        data: {
          ApiKey.email: resetPasswdRequest['email'],
          ApiKey.newPassword: resetPasswdRequest['password'],
          ApiKey.code: resetPasswdRequest['code'],
        },
      );
      MessageModel message;
      if(response.statusCode == 200){
          message = MessageModel.fromJson(response.data);
        return Right(message);
      }
      if(response.statusCode == 400){
          message = MessageModel.fromJson(response.data);
        return Left(message);
      }
      message = MessageModel(success: false, message: "Failed to reset password");
      
        return Left(message);
      
      
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<MessageModel, MessageModel>> uploadProfilePic(File? selectedImage) async {
    try {
      FormData formData = FormData.fromMap({
        ApiKey.image: await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage.path.split('/').last,
        ),
      });
      return api.post(
        EndPoint.uploadProfilePic,
        data: formData,
      ).then((response) {
        if (response.statusCode == 200) {
          return Right(MessageModel.fromJson(response.data));
        }
        return Left(MessageModel(message: "Failed to upload profile picture"));
      });
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }
  Future<Either<MessageModel, ProfileImageModel>> getProfilePic() async {
    try {
      final Response response = await api.get(
        EndPoint.uploadProfilePic,
        isFromData: true
      );
      if (response.statusCode == 200) {
        return Right(ProfileImageModel.setImage(response.data));
      }
      return Left(MessageModel(message: "Failed to update profile"));
    } on ServiceException catch (e) {
      return Left(e.errModel.message);
    }
  }
}
