import 'package:ultra/network/network_result.dart';
import 'package:dio/dio.dart';

class NetworkResultWrapper {
  static Future<NetworkResult<T>> getResult<T>(
    Future<NetworkResult<T>> Function() callback,
  ) async {
    try {
      return await callback();
    } on DioException catch (error) {
      return NetworkError(
        ErrorBody(
          rawMessage: error.response?.data,
          code: error.response?.statusCode,
        ),
        error,
      );
    } on FormatException catch (error) {
      return NetworkError(ErrorBody(message: kDefaultErrorMsg), error);
    } on Exception catch (error) {
      return NetworkError(ErrorBody(message: kDefaultErrorMsg), error);
    }
  }
}
