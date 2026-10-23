import 'package:dio/dio.dart';
import 'package:dio_curl_logger/dio_curl_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/api_client_interceptor.dart';
import 'package:flutter_bloc_clean_architecture/data/network/token_refresh_util.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/auth_storage_service.dart';

Dio createDio(
  String baseUrl, {
  required AuthStorageService authStorageService,
  bool interceptorEnable = true,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(
        seconds: ConfigsConstant.networkConnectTimeoutSeconds,
      ),
      receiveTimeout: const Duration(
        seconds: ConfigsConstant.networkReceiveTimeoutSeconds,
      ),
      contentType: Headers.jsonContentType,
    ),
  );

  if (interceptorEnable) {
    dio.interceptors.add(
      ApiClientInterceptor(
        dio: dio,
        authStorageService: authStorageService,
        tokenRefreshUtil: TokenRefreshUtil(
          baseUrl: baseUrl,
          authStorageService: authStorageService,
        ),
      ),
    );
  }

  if (kDebugMode) {
    dio.interceptors.add(
      CurlLoggingInterceptor(showRequestLog: true, showResponseLog: true),
    );
  }
  return dio;
}
