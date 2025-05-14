import 'package:app/core/api/end_ponits.dart';
import 'package:app/models/message_model.dart';

class ErrorModel {
  final int code;
   final MessageModel message;

   ErrorModel({
     required this.code,
     MessageModel? message,
   }) : message = message ?? MessageModel(
         message: 'Unknown error',
       );

  factory ErrorModel.fromJson(dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return ErrorModel(
          code: data[ApiKey.code] ?? 0,
          message: data[ApiKey.message] ?? 'Unknown error',
        );
      } else {
        return ErrorModel(
          code: 0,
          message: MessageModel(message: data.toString()), // في حال الرد عبارة عن نص
        );
      }
    } catch (e) {
      return ErrorModel(
        code: 0,
        message: MessageModel(message: 'Unexpected error format'),
      );
    }
  }
}
