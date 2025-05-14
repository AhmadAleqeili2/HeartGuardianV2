import 'package:dio/dio.dart';
import 'package:app/core/api/api_consumer.dart';
import 'package:app/core/api/api_interceptors.dart';
import 'package:app/core/api/end_ponits.dart';
import 'package:app/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
      );
      return response;
    } on DioException catch (e) {
     throw handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data ,bool isFromData = false,}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        options: Options(
          responseType: isFromData ? ResponseType.bytes : ResponseType.json,
        ),
      );
      return response;
    } on DioException catch (e) {
    throw  handleDioExceptions(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
      );
      return response;
    } on DioException catch (e) {
     throw handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
      );
      return response;
    } on DioException catch (e) {
    throw  handleDioExceptions(e);
    }
  }
}
