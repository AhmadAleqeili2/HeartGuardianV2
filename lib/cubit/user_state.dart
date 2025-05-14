import 'package:app/models/feedback_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/notification_model.dart';
import 'package:app/models/profile_image_model.dart';
import 'package:app/models/user_model.dart';
import 'dart:developer';
class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {
   final String message;
  SignInSuccess({required this.message});
}
class GetProfilePicLoading  extends UserState {

}

class GetProfilePicFailure extends UserState {
  final MessageModel message;

  GetProfilePicFailure({required this.message}) {
    log('GetProfilePicFailure: ${message.toString()}');
  }
}

class GetProfilePicSuccess extends UserState {
  final ProfileImageModel profileImage;

  GetProfilePicSuccess({required this.profileImage}) {
    log('GetProfilePicSuccess: ${profileImage.toString()}');
  }
}
final class UploadProfilePicLoading extends UserState {}
final class UploadProfilePicSuccess extends UserState {
  final MessageModel message;

  UploadProfilePicSuccess({required this.message});
}
final class UploadProfilePicFailure extends UserState {
  final MessageModel message;

  UploadProfilePicFailure({required this.message}) {
    log('UploadProfilePicFailure: $message');
  }
}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String message;

  SignInFailure({required this.message});
}

final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String message;

  SignUpFailure({required this.message});
}

final class GetUserSuccess extends UserState {
  final UserModel user;

  GetUserSuccess({required this.user});
}

final class GetUserLoading extends UserState {}

final class GetUserFailure extends UserState {
  final String errMessage;

  GetUserFailure({required this.errMessage}) {
    log('GetUserFailure: $errMessage');
  }
}
final class DeleteAccLoading extends UserState {}
final class DeleteAccSuccess extends UserState {
  final String message;

  DeleteAccSuccess({required this.message});
}
final class DeleteAccFailure extends UserState {
  final String message;

  DeleteAccFailure({required this.message});
}
final class SentHistoryLoading extends UserState {}
final class SentHistorySuccess extends UserState {
  final String message;

  SentHistorySuccess({required this.message});
}
final class SentHistoryFailure extends UserState {
  final String message;

  SentHistoryFailure({required this.message});
}
final class SentNotificationLoading extends UserState {}
final class SentNotificationSuccess extends UserState {
  final String message;

  SentNotificationSuccess({required this.message});
}
final class SentNotificationFailure extends UserState {
  final String message;

  SentNotificationFailure({required this.message});
}
final class SentFeedBackLoading extends UserState {}
final class SentFeedBackSuccess extends UserState {
  final String message;

  SentFeedBackSuccess({required this.message});
}
final class SentFeedBackFailure extends UserState {
  final String message;

  SentFeedBackFailure({required this.message});
}
final class GetHistoryLoading extends UserState {}
final class GetHistorySuccess extends UserState {
  final List<HistoryModel> history;

  GetHistorySuccess({required this.history});
}
final class GetHistoryFailure extends UserState {
  final MessageModel errMessage;

  GetHistoryFailure({required this.errMessage}) {
    log('GetUserFailure: ${errMessage.toString()}');
  }
}
final class GetNotificationLoading extends UserState {}
final class GetNotificationSuccess extends UserState {
  final List<NotificationModel> notification;

  GetNotificationSuccess({required this.notification});
}
final class GetNotificationFailure extends UserState {
  final MessageModel message;

  GetNotificationFailure({required this.message}) {
    log('GetUserFailure: ${message.toString()}');
  }
}
final class GetFeedBackLoading extends UserState {}
final class GetFeedBackSuccess extends UserState {
  final FeedBackModel feedback;

  GetFeedBackSuccess({required this.feedback});
}
final class GetFeedBackFailure extends UserState {
  final String errMessage;

  GetFeedBackFailure({required this.errMessage}) {
    log('GetUserFailure: $errMessage');
  }
}

class FeedBackCheckLoading  extends UserState {}
class FeedBackCheckSuccess extends UserState {
  final String feedback;
  final bool isCheck;

  FeedBackCheckSuccess( {required this.isCheck, required this.feedback});
}
class FeedBackCheckFailure extends UserState {
  final String errMessage;

  FeedBackCheckFailure({required this.errMessage}) {
    log('GetUserFailure: $errMessage');
  }
}

  class UpdatePasswordSuccess extends UserState{
      final MessageModel message;

  UpdatePasswordSuccess({required this.message}){
    log('UpdatePasswordSuccess: ${message.toString()}');
  }
  }
  
  class UpdatePasswordFailure extends UserState{
          final MessageModel message;

  UpdatePasswordFailure({required this.message}){
    log('UpdatePasswordFailure: ${message.toString()}');
  }
  }
  
  class UpdatePasswordLoading extends UserState{
  }
  

  
  class ForgotPasswordSuccess extends UserState{
    final MessageModel message;
  
    ForgotPasswordSuccess({required this.message}){
      log('ForgotPasswordSuccess: ${message.toString()}');
  }
  }
  class ForgotPasswordFailure extends UserState{
    final MessageModel message;
  
    ForgotPasswordFailure({required this.message}){
      log('ForgotPasswordFailure: ${message.toString()}');
    }
  }
  
  class ResetPasswordRequestLoading extends UserState{

  }
  
  class ResetPasswordRequestSuccess extends UserState{
    final MessageModel message;
  
    ResetPasswordRequestSuccess({required this.message}){
      log('ResetPasswordRequestSuccess: ${message.toString()}');
    }
  }
  
  class ResetPasswordRequestFailure extends UserState{
    final MessageModel message;
  
    ResetPasswordRequestFailure({required this.message}){
      log('ResetPasswordRequestFailure: ${message.toString()}');
    }
  }
  
  class ForgotPasswordLoading extends UserState{
    }