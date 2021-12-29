import 'dart:collection';
import 'dart:developer';

import 'package:khudrah_companies/network/API/api_config.dart';

import 'package:dio/dio.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';

class RegisterRepository {
  final RestClient _client;

  //todo: handle error
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
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      // とりあえずここではサーバー側のエラーメッセージを表示するようにしとく
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }
}
