import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';

class BranchRepository {
  late final RestClient _client;
  static String token ='';


  BranchRepository([RestClient? client]) {
//    String selectedLanguage = PreferencesHelper.getLanguage()!;
   PreferencesHelper.getUserToken.then((value) {
     token = value;
   });

   Map<String, dynamic> headerMap = {
     //  "language" : "$selectedLanguage",
     "Authorization": "Bearer $token"
   };
   print('map is $headerMap');

   _client = RestClient(Dio(
     BaseOptions(contentType: 'application/json', headers: headerMap),
   ));
  }




  //-----------------------------------
  Future<ApiResponse> addNewBranch(
      String companyId,
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
