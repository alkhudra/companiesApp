import 'dart:convert';
import 'dart:developer';

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

class RegisterRepository {
  final RestClient _client;

  RegisterRepository([RestClient? client])
      : _client = client ?? RestClient(Dio());

  Future<ApiResponse> registerUser(
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      String ownerName,
      String companyName,
      String commercialRegistrationNo,
      int branchNumber) async {
    if (email == null ||
        password == null ||
        confirmPassword == null ||
        phoneNumber == null ||
        ownerName == null ||
        companyName == null ||
        commercialRegistrationNo == null ||
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
              if (map.contains('message')) {
                errorMessage = res.data['message'];
              } else {
                final de = jsonDecode(res.data.toString());
                FailRegisterResponseModel model = FailRegisterResponseModel.fromJson(de);
                if (model.errors!.confirmPassword!.isNotEmpty) {
                  errorMessage = model.errors!.confirmPassword!.first;
                } else
                  errorMessage = model.errors!.password!.first;
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

  Future<ApiResponse> loginUser(String email, String password) async {
    if (email == null || password == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
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

              if (model.companyStatus == null)
                errorMessage = model.message!;
              else {
                switch (model.companyStatus) {
                  case waiting_confirmation:
                    errorMessage = LocaleKeys.auth_note.tr();
                    break;
                  case waiting_approval:
                    errorMessage = LocaleKeys.waiting_approval.tr();
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
            if(errorCode == 500)
              errorMessage = res.data['Message'];
            else  if(errorCode == 400)
              errorMessage = LocaleKeys.email_not_valid.tr();
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
/*
  Future<ApiResponse> sendPasswordToken(String email, String token) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {"email": email, "token": token};

    return await _client
        .sendCodeForgetPassword(hashMap)
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

          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }
*/

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
            }else if(errorCode ==400){


              print(res.data);
              String map = res.data.toString();
              if (map.contains('message')) {
                errorMessage = res.data['message'];
              } else {
                final de = jsonDecode(res.data.toString());
                FailResetPasswordResponseModel model = FailResetPasswordResponseModel.fromJson(de);
                if (model.errors!.confirmPassword!.isNotEmpty) {
                  errorMessage = model.errors!.confirmPassword!.first;
                }
                else if (model.errors!.email!.isNotEmpty) {
                  errorMessage = model.errors!.email!.first;
                }
                else  if (model.errors!.token!.isNotEmpty) {
                  errorMessage = model.errors!.token!.first;
                }
                else
                  errorMessage = model.errors!.password!.first;
              }
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

  Future<ApiResponse> getUserInfo(String companyID) async {
    if (companyID == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }


    return await _client
        .getUserInfo(companyID)
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
}
