import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/request_extra_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/api_client_interceptor.dart';
import 'package:flutter_bloc_clean_architecture/data/network/token_refresh_util.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/app_events.dart';
import 'package:flutter_bloc_clean_architecture/common/services/event_bus/event_bus_service.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory storage, no secure storage plugin involved.
class _FakeAuthStorage extends AuthStorageService {
  AuthSession? session;

  _FakeAuthStorage(this.session);

  @override
  Future<AuthSession?> getSession() async => session;

  @override
  Future<void> saveSession(AuthSession session) async => this.session = session;

  @override
  Future<void> deleteSession() async => session = null;
}

class _FakeTokenRefresh extends TokenRefreshUtil {
  final _FakeAuthStorage storage;
  final TokenRefreshResult result;
  int calls = 0;

  _FakeTokenRefresh(this.storage, {this.result = TokenRefreshResult.success})
    : super(baseUrl: 'https://test', authStorageService: storage);

  @override
  Future<TokenRefreshResult> refreshToken() async {
    calls++;
    await Future<void>.delayed(const Duration(milliseconds: 20));
    if (result == TokenRefreshResult.success) {
      await storage.saveSession(const AuthSession(accessToken: 'new'));
    }
    return result;
  }
}

/// Accepts only `Bearer new`; everything else gets a 401.
///
/// Paths starting with `/slow` answer after [slowDelay], to simulate a request
/// sent with the old token whose 401 arrives after the refresh has finished.
/// [rejectAll] makes the server refuse even the refreshed token.
class _FakeAdapter implements HttpClientAdapter {
  int requests = 0;
  bool rejectAll = false;
  Duration slowDelay = const Duration(milliseconds: 100);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests++;
    if (options.path.startsWith('/slow')) await Future<void>.delayed(slowDelay);
    final isValid =
        !rejectAll && options.headers['Authorization'] == 'Bearer new';
    return ResponseBody.fromString(
      '{}',
      isValid ? 200 : 401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late _FakeAuthStorage storage;
  late _FakeAdapter adapter;
  late Dio dio;

  Dio buildDio(_FakeTokenRefresh refresh) {
    final dio = Dio(BaseOptions(baseUrl: 'https://test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(
      ApiClientInterceptor(
        dio: dio,
        authStorageService: storage,
        tokenRefreshUtil: refresh,
      ),
    );
    return dio;
  }

  setUp(() {
    storage = _FakeAuthStorage(
      const AuthSession(accessToken: 'old', refreshToken: 'refresh'),
    );
    adapter = _FakeAdapter();
  });

  test('concurrent 401s trigger a single refresh and all succeed', () async {
    final refresh = _FakeTokenRefresh(storage);
    dio = buildDio(refresh);

    final responses = await Future.wait(
      List.generate(5, (i) => dio.get<dynamic>('/items/$i')),
    );

    expect(refresh.calls, 1);
    expect(responses.every((r) => r.statusCode == 200), isTrue);
  });

  test(
    '401 arriving after the refresh finished: replayed, no new refresh',
    () async {
      final refresh = _FakeTokenRefresh(storage);
      dio = buildDio(refresh);

      // Both are sent with the old token. The fast one triggers the refresh
      // (done after ~20ms); the slow one gets its 401 at ~100ms, after the
      // single-flight refresh is already over.
      final responses = await Future.wait([
        dio.get<dynamic>('/fast'),
        dio.get<dynamic>('/slow'),
      ]);

      expect(refresh.calls, 1);
      expect(responses.every((r) => r.statusCode == 200), isTrue);
    },
  );

  test('server rejects the new token too: one refresh, no loop', () async {
    final refresh = _FakeTokenRefresh(storage);
    adapter.rejectAll = true;
    dio = buildDio(refresh);

    final results = await Future.wait(
      List.generate(
        5,
        (i) => dio
            .get<dynamic>('/items/$i')
            .then((_) => true)
            .catchError((_) => false),
      ),
    );

    expect(results, everyElement(isFalse));
    expect(refresh.calls, 1);
    // 5 original requests + 5 replays, then each one stops.
    expect(adapter.requests, 10);
  });

  test('401 on an auth endpoint does not refresh', () async {
    final refresh = _FakeTokenRefresh(storage);
    dio = buildDio(refresh);

    await expectLater(
      dio.post<dynamic>(
        '/auth/login',
        options: Options(extra: {RequestExtraConstant.skipAuthRefresh: true}),
      ),
      throwsA(isA<DioException>()),
    );
    expect(refresh.calls, 0);
    expect(storage.session, isNotNull);
  });

  test('rejected refresh clears session and fires one event', () async {
    final refresh = _FakeTokenRefresh(
      storage,
      result: TokenRefreshResult.invalidSession,
    );
    dio = buildDio(refresh);
    var events = 0;
    final sub = EventBusService.instance.on<SessionExpiredEvent>().listen(
      (_) => events++,
    );

    final results = await Future.wait(
      List.generate(
        3,
        (i) => dio
            .get<dynamic>('/items/$i')
            .then((_) => true)
            .catchError((_) => false),
      ),
    );
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(results, everyElement(isFalse));
    expect(refresh.calls, 1);
    expect(storage.session, isNull);
    expect(events, 1);
  });

  test('network failure during refresh keeps the session', () async {
    final refresh = _FakeTokenRefresh(
      storage,
      result: TokenRefreshResult.failed,
    );
    dio = buildDio(refresh);

    await expectLater(
      dio.get<dynamic>('/items/1'),
      throwsA(isA<DioException>()),
    );
    expect(storage.session?.accessToken, 'old');
  });
}
