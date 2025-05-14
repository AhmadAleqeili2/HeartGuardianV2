import 'package:app/core/errors/error_model.dart';
import 'package:app/core/errors/service_exception.dart';
import 'package:app/models/message_model.dart';
import 'package:dio/dio.dart';

ServiceException handleDioExceptions(DioException e) {
  final dynamic errorData = e.response?.data;

  ErrorModel errorModel = ErrorModel.fromJson(
    errorData ?? 'Unknown error occurred.',
  );

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return ServiceException(errModel: errorModel); // ✅

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
        case 422:
        case 504:
          return ServiceException(errModel: errorModel); // ✅
        default:
          return ServiceException(
              errModel: ErrorModel(
            code: statusCode ?? 0,
            message: MessageModel(message: 'Unknown server error'),
          ));
      }
  }
}

