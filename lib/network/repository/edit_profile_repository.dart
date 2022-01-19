import 'dart:convert';
import 'dart:developer';

import 'package:khudrah_companies/network/network_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:dio/dio.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/fail_edit_profile_response_model.dart';

class ProfileRepository {
  late final RestClient _client;

  ProfileRepository(Map<String, dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }




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
                final de = jsonDecode(res.data.toString());
                FailEditProfileResponseModel model =
                    FailEditProfileResponseModel.fromJson(de);
                if (model.errors!.commercialRegistrationNo!.isNotEmpty) {
                  errorMessage = model.errors!.commercialRegistrationNo!.first;
                } else
                  errorMessage = model.errors!.phoneNumber!.first;
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
}
