import 'package:app/core/errors/error_model.dart';

class ServiceException implements Exception {
  final ErrorModel errModel;

  ServiceException({required this.errModel});

  @override
  String toString() => 'ServiceException: ${errModel.message}';
}