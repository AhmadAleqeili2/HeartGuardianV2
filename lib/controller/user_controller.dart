
import 'dart:io';

import 'package:app/models/feedback_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/notification_model.dart';
import 'package:app/models/profile_image_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/services/user_service.dart';
import 'package:dartz/dartz.dart';
class UserController {
  UserService userService = UserService();
 Future<Either<MessageModel, UserModel>> getUserProfile() {
    return userService.getUser();
  }

 Future<Either<MessageModel,MessageModel>>deleteAccount() {

  return userService.deleteAccount();
  }

  Future<Either<MessageModel, MessageModel>>sentHistory(Map<String,dynamic> history) {
    return userService.sentHistory(history);
  }

  Future<Either<MessageModel, MessageModel>>sentNotification(String notification) {
    return userService.sentNotification(notification);
  }

  Future<Either<MessageModel, MessageModel>>sentFeedBack(String feedBack) {
    return userService.sentFeedBack(feedBack);
  }

  Future<Either<MessageModel, FeedBackModel>>getFeedBack() {
    return userService.getFeedBack();
  }

  Future<Either<MessageModel, List<HistoryModel>>>getHistory() {
    return userService.getHistory();
  }

  Future<Either<MessageModel, List<NotificationModel>>>getNotification() {
    return userService.getNotification();
  }

  Future<bool> feedBackCheck() {
    return userService.feedBackCheck();
  }

 Future<Either<MessageModel, MessageModel>> uploadProfilePic(File? selectedImage) {
  return userService.uploadProfilePic(selectedImage);

  }
  Future<Either<MessageModel, ProfileImageModel>> getProfilePic() {
    return userService.getProfilePic();
  }
 }
