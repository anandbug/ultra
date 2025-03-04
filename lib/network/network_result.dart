import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_result.freezed.dart';

@freezed
sealed class NetworkResult<T> with _$NetworkResult<T> {
  const factory NetworkResult.success(T data) = NetworkSuccess<T>;
  const factory NetworkResult.error(ErrorBody<T> body, Exception e) =
      NetworkError<T>;
}

final class ErrorBody<T> {
  const ErrorBody({
    this.message = kDefaultErrorMsg,
    this.rawMessage,
    this.code = -1,
  });

  final String message;
  final int? code;
  final T? rawMessage;
}

const kDefaultErrorMsg = "OOPS! Something went wrong";
