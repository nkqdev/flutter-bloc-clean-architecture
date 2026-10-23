import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/api_endpoints_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/request_extra_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/models/auth/request/login_request_model.dart';
import 'package:flutter_bloc_clean_architecture/data/models/auth/response/auth_info_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiEndpointsConstant.login)
  @Extra({RequestExtraConstant.skipAuthRefresh: true})
  Future<AuthInfoModel> login(@Body() LoginRequestModel request);

  @POST(ApiEndpointsConstant.logout)
  @Extra({RequestExtraConstant.skipAuthRefresh: true})
  Future<void> logout();
}
