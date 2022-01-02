import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:khudrah_companies/Constant/api_const.dart';
import 'package:khudrah_companies/network/models/login_response_model.dart';
import 'package:khudrah_companies/network/models/register_class.dart';
import 'package:khudrah_companies/network/models/register_response_model.dart';
import 'package:khudrah_companies/network/models/string_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_config.g.dart';
/*flutter pub run build_runner watch
*
* run when made any changes here
* */
@RestApi(baseUrl: ApiConst.basic_url)
abstract class RestClient {


  //todo:with token , language
  factory RestClient(Dio dio,{String? baseUrl}) = _RestClient;/*{
    {

      dio.options = BaseOptions(
          receiveTimeout: 30000,
          connectTimeout: 30000,
          contentType: 'application/json',
          *//* If needed headers *//*


   *//*       if (withToken) {
        String tokenType = PreferencesHelper.getTokenType("Bearer");
        String token = PreferencesHelper.getToken("");

        requestBuilder.header("Authorization", tokenType + " " + token);
      }*//*
          headers: {
           // 'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
            'X-ApiKey': 'ZGslzIzEyMw==',
            'Content-Type': 'application/json'
          }
      );

      return _RestClient(dio,withToken,baseUrl:baseUrl);
    }
  }*/






  @POST(ApiConst.register_url)
  Future<RegisterResponseModel> registerUser(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.login_url)
  Future<LoginResponseModel> loginUser(@Body() Map<String, dynamic> hashMap);


  @POST(ApiConst.forget_password_url)
  Future<String> forgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.check_password_token_url)
  Future<String> sendCodeForgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.reset_password_url)
  Future<String> resetPassword(@Body() Map<String, dynamic> hashMap);
}

