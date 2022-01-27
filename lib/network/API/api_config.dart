
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/network/models/auth/forget_password_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_config.g.dart';

/*flutter pub run build_runner watch
*
* run when made any changes here
* */
@RestApi(baseUrl: ApiConst.basic_url)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;
  //---------------auth ----------------

  @POST(ApiConst.register_url)
  Future<dynamic> registerUser(
      @Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.login_url)
  Future<dynamic> loginUser(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.forget_password_url)
  Future<ForgetPasswordResponseModel> forgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.check_password_token_url)
  Future<String> sendCodeForgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.reset_password_url)
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.update_profile_url)
  Future<dynamic> updateProfileInfo(@Path() String id ,@Body() Map<String, dynamic> hashMap);

  @GET(ApiConst.get_user_info_url)
  Future<dynamic> getUserInfo(@Path() String id);
//---------------branch ----------------
  @POST(ApiConst.add_branch_url)
  Future<dynamic> addNewBranch(@Path() String id  ,@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.update_branch_url)
  Future<dynamic> editBranch(@Path() String id  ,@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.delete_branch_url)
  Future<dynamic> deleteBranch(@Path() String id  );

  @GET(ApiConst.get_branch_url)
  Future<dynamic> getAllBranches(@Path() String id);

//---------------home ----------------

  @GET(ApiConst.get_home_url)
  Future<dynamic> getHomeInfo();


  @GET(ApiConst.get_products_url)
  Future<dynamic> getProducts(@Query('PageNumber') int PageNumber, @Query('PageSize') int  PageSize);


  @GET(ApiConst.get_products_by_category_url)
  Future<dynamic> getProductsByCategory(@Query('categoryId')String categoryId, @Query('PageNumber') int PageNumber, @Query('PageSize') int  PageSize);


  @GET(ApiConst.get_products_by_id_url)
  Future<dynamic> getProductById(@Query('productId') String productId);


}
