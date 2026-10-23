import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/data/network/constants/api_endpoints_constant.dart';
import 'package:flutter_bloc_clean_architecture/data/models/paginate/paginate_model.dart';
import 'package:flutter_bloc_clean_architecture/data/models/user/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String? baseUrl}) = _UserApiService;

  @GET(ApiEndpointsConstant.users)
  Future<PaginateModel<UserModel>> getUsers({
    @Query('PageNumber') required int pageNumber,
    @Query('PageSize') required int pageSize,
    @Query('Keyword') String? keyword,
  });

  @GET(ApiEndpointsConstant.userDetail)
  Future<UserModel> getUserDetail(@Path('id') String id);

  @GET(ApiEndpointsConstant.userProfile)
  Future<UserModel> getUserProfile();
}
