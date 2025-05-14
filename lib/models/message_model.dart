import 'package:app/core/api/end_ponits.dart';

class MessageModel {
  bool success;
  String message;
  MessageModel({
    this.success = false,
    this.message = '',
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      success: true,
      message: json[ApiKey.message],
    );
  }
}