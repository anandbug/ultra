import 'package:dio/dio.dart';
import 'package:ultra/utils/num_extensions.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(connectTimeout: 10.seconds, receiveTimeout: 10.seconds),
      ) {
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    ); // Optional: for debugging
  }

  Dio get dio => _dio;
}
