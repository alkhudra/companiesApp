import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:easy_localization/easy_localization.dart';
class BranchRepository {
  late final RestClient _client;



  BranchRepository(Map<String,dynamic> headerMap) {

   _client = RestClient(Dio(
     BaseOptions(contentType: 'application/json', headers: headerMap),
   ));
  }

  //-----------------------------------

  Future<ApiResponse> getAllBranch(
      String companyId) async {
    if (companyId == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }


    return await _client
        .getAllBranches(companyId)
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
            }else{
              errorMessage = LocaleKeys.wrong_error.tr();
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


  //-----------------------------------
  Future<ApiResponse> addNewBranch(
      String companyId,
      String branchName,
      String phoneNumber,
      String distName,
      String streetName,
      String city,
      String adress,
      String nationalIDAddress,
      double longitude,
      double latitude) async {
    if (branchName == null ||
        phoneNumber == null ||
        adress == null ||
        nationalIDAddress == null ||
        longitude == null ||
        latitude == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "branchName": branchName,
      "phoneNumber": phoneNumber,
      "districtName": distName,
      "streetName": streetName,
      "city": city,
      "adress": adress,
      "nationalIDAddress": nationalIDAddress,
      "longitude": longitude,
      "latitude": latitude
    };

    return await _client
        .addNewBranch(companyId, hashMap)
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
            }else{
              errorMessage = LocaleKeys.wrong_error.tr();
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



  //-----------------------------------
  Future<ApiResponse> editBranch(
      String branchId,
      String branchName,
      String phoneNumber,
      String adress,
      String zipCode,
      double longitude,
      double latitude) async {
    if (branchName == null ||
        phoneNumber == null ||
        adress == null ||
        zipCode == null ||
        longitude == null ||
        latitude == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "branchName": branchName,
      "phoneNumber": phoneNumber,
      "adress": adress,
      "zipCode": zipCode,
      "longitude": longitude,
      "latitude": latitude
    };

    return await _client
        .editBranch(branchId, hashMap)
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
            }else{
              errorMessage = LocaleKeys.wrong_error.tr();
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


  //-----------------------------------
  Future<ApiResponse> deleteBranch(
      String branchId) async {
    if (branchId == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }


    return await _client
        .deleteBranch(branchId)
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
            }else{
              errorMessage = LocaleKeys.wrong_error.tr();
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
