import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/failure_mapper.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _response(int statusCode, [Object? data]) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  test('maps transport errors', () {
    final options = RequestOptions(path: '/x');
    expect(
      mapErrorToFailure(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      ),
      isA<NetworkFailure>(),
    );
    expect(
      mapErrorToFailure(
        DioException(
          requestOptions: options,
          type: DioExceptionType.receiveTimeout,
        ),
      ),
      isA<TimeoutFailure>(),
    );
  });

  test('maps HTTP status codes and keeps server message', () {
    expect(mapErrorToFailure(_response(401)), isA<UnauthorizedFailure>());
    expect(mapErrorToFailure(_response(403)), isA<ForbiddenFailure>());
    expect(mapErrorToFailure(_response(404)), isA<NotFoundFailure>());
    expect(mapErrorToFailure(_response(503)), isA<ServerFailure>());

    final failure = mapErrorToFailure(
      _response(422, {'message': 'Email đã tồn tại', 'errorCode': 'E01'}),
    );
    expect(failure, isA<ValidationFailure>());
    expect(failure.message, 'Email đã tồn tại');
    expect(failure.code, 'E01');
  });

  test('maps unknown errors', () {
    expect(mapErrorToFailure(StateError('x')), isA<UnknownFailure>());
  });
}
