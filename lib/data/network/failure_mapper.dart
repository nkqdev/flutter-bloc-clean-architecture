import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';

/// Converts any error thrown by the data sources into a domain [Failure].
Failure mapErrorToFailure(Object error) {
  if (error is Failure) return error;
  if (error is DioException) return _mapDioException(error);
  return UnknownFailure(message: error.toString());
}

Failure _mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return TimeoutFailure(message: error.message);
    case DioExceptionType.connectionError:
      return NetworkFailure(message: error.message);
    case DioExceptionType.badResponse:
      return _mapBadResponse(error.response);
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return UnknownFailure(message: error.message);
  }
}

Failure _mapBadResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode;
  final data = response?.data;
  final body = data is Map<String, dynamic> ? data : const <String, dynamic>{};
  final message = body['message'] as String?;
  final code = (body['errorCode'] ?? body['code'])?.toString();

  return switch (statusCode) {
    400 || 422 => ValidationFailure(message: message, code: code),
    401 => UnauthorizedFailure(message: message, code: code),
    403 => ForbiddenFailure(message: message, code: code),
    404 => NotFoundFailure(message: message, code: code),
    final int status when status >= 500 => ServerFailure(
      statusCode: status,
      message: message,
      code: code,
    ),
    _ => UnknownFailure(message: message, code: code),
  };
}
