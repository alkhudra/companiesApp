import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:dio/dio.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/fail_register_response_model.dart';
import 'package:khudrah_companies/network/models/auth/fail_login_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/models/auth/fail_reset_password_response_model.dart';
import 'package:khudrah_companies/network/models/error_response_model.dart';

class AuthRepository {
  late final RestClient _client;

  AuthRepository(Map<String,dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json',headers: headerMap),
    ));
  }

  Future<ApiResponse> registerUser(
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      String ownerName,
      String companyName,
      String commercialRegistrationNo,
      String vatNo,
      int branchNumber) async {
    if (email == null ||
        password == null ||
        confirmPassword == null ||
        phoneNumber == null ||
        ownerName == null ||
        companyName == null ||
        commercialRegistrationNo == null ||
        vatNo == null ||
        branchNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phoneNumber": phoneNumber,
      "ownerName": ownerName,
      "companyName": companyName,
      "commercialRegistrationNo": commercialRegistrationNo,
      "vatNo": vatNo,
      "branchNumber": branchNumber
    };

    return await _client
        .registerUser(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
            if (errorCode == 400) {
              print(res.data);
              String map = res.data.toString();
              if (!map.contains('error')) {
                errorMessage = res.data['message'];
              } else {
                ErrorResponseModel errorResponseModel =
                    ErrorResponseModel.fromJson(res.data);
                errorMessage = errorResponseModel.error!.message!;
                print(errorMessage);
              }
            } else if (errorCode == 500) {
              errorMessage = res.data['Message'];
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

  //--------------------------

  Future<ApiResponse> loginUser(
      String email, String password, deviceId) async {
    if (email == null || password == null || deviceId == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    int isAndroiodDevice ;
    if(Platform.isAndroid)
    isAndroiodDevice =1;
     else isAndroiodDevice =2;


    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "rememberMe": true,
      "isAndroiodDevice": true,
      "deviceId": deviceId,
      "deviceType" : isAndroiodDevice
    };

    return await _client
        .loginUser(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;

            if (errorCode == 400) {
              FailLoginResponseModel model =
                  FailLoginResponseModel.fromJson(res.data);

              if (model.companyStatus == null) {
                if (model.message != null) errorMessage = model.message!;
              } else {
                switch (model.companyStatus) {
                  case waiting_confirmation:
                    errorMessage = LocaleKeys.auth_note.tr();
                    break;
                  case waiting_approval:
                    errorMessage = LocaleKeys.waiting_approval.tr();
                    break;
                  case rejected:
                    errorMessage = LocaleKeys.rejected.tr();
                    break;
                  case registered:
                    errorMessage = LocaleKeys.worng_password.tr();
                    break;
                }
              }
            } else if (errorCode == 500) {
              errorMessage = res.data['Message'];
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

//-----------------------------

  Future<ApiResponse> forgetPassword(String email) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
    };

    return await _client
        .forgetPassword(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
            if (errorCode == 500)
              errorMessage = res.data['Message'];
            else if (errorCode == 400) {
              // final de = jsonDecode(res.data.toString());
              ErrorResponseModel errorResponseModel =
                  ErrorResponseModel.fromJson(res.data);
              errorMessage = errorResponseModel.error!.message!;
              print(errorMessage);
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

  //-----------------

  Future<ApiResponse> resetPassword(String email, String password,
      String confirmPassword, String token) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "token": token
    };

    return await _client
        .resetPassword(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
            if (errorCode == 500) {
              errorMessage = res.data['Message'];
            } else if (errorCode == 400) {
              // final de = jsonDecode(res.data.toString());
              ErrorResponseModel errorResponseModel =
                  ErrorResponseModel.fromJson(res.data);
              errorMessage = errorResponseModel.error!.message!;
              print(errorMessage);
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

  //-----------------

}
