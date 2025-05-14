import 'dart:io';

import 'package:app/core/api/dio_consumer.dart';
import 'package:app/models/feedback_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/notification_model.dart';
import 'package:app/models/profile_image_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserService {
UserRepository userRepository = UserRepository(api: DioConsumer(dio: Dio()));

  Future<Either<MessageModel, UserModel>>getUser() async {
 return await userRepository.getUserProfile();

}

  Future<Either<MessageModel,MessageModel>> deleteAccount() {
    return userRepository.deleteAccount();
  }

  Future<Either<MessageModel, MessageModel>> sentHistory(Map<String, dynamic> history) {
    return userRepository.sentHistory(history);
  }

  Future<Either<MessageModel, MessageModel>> sentNotification(String notification) {
    return userRepository.sentNotification(notification);
  }

  Future<Either<MessageModel, MessageModel>> sentFeedBack(String feedBack) {
    return userRepository.sentFeedBack(feedBack);
  }

  Future<Either<MessageModel, FeedBackModel>> getFeedBack() {
    return userRepository.getFeedBack();
  }

  Future<Either<MessageModel, List<HistoryModel>>> getHistory() {
    return userRepository.getHistory();
  }

  Future<Either<MessageModel, List<NotificationModel>>> getNotification() {
    return userRepository.getNotification();
  }

  Future<bool> feedBackCheck() {
    return userRepository.feedBackCheck();
  }

  Future<Either<MessageModel, MessageModel>> uploadProfilePic(File? selectedImage) {
    return userRepository.uploadProfilePic(selectedImage);
  }
  
  Future<Either<MessageModel, ProfileImageModel>> getProfilePic() {
    return userRepository.getProfilePic();
    }
  }