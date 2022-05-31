import 'dart:developer';

import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/route_helper.dart';
import 'package:khudrah_companies/network/models/error_response_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:dio/dio.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/fail_edit_profile_response_model.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeRepository {
  late final RestClient _client;

  HomeRepository(Map<String, dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }

  Future<ApiResponse> getHomeInfo(context) async {
    return await _client
        .getHomeInfo()
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
            if (errorCode == 401)
              logoutUser(context);
            else
              errorMessage = LocaleKeys.wrong_error.tr();
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

  Future<ApiResponse> updateProfile(
      String companyID,
      String email,
      String phoneNumber,
      String ownerName,
      String companyName,
      String commercialRegistrationNo,
      String vatNo,
      int branchNumber) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "phoneNumber": phoneNumber,
      "ownerName": ownerName,
      "companyName": companyName,
      "commercialRegistrationNo": commercialRegistrationNo,
      "vatNo": vatNo,
      "branchNumber": branchNumber
    };

    return await _client
        .updateProfileInfo(companyID, hashMap)
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
              print(res.data);
              String map = res.data.toString();
              if (map.contains('message')) {
                errorMessage = res.data['message'];
              } else {
                if (errorCode == 400) {
                  // final de = jsonDecode(res.data.toString());
                  ErrorResponseModel errorResponseModel =
                      ErrorResponseModel.fromJson(res.data);
                  errorMessage = errorResponseModel.error!.message!;
                  print(errorMessage);
                }
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

  Future<ApiResponse> getContactInfo() async {
    return await _client
        .getContactInfo()
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
          } else
            errorMessage = LocaleKeys.wrong_error.tr();

          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }
}
