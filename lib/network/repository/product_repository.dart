import 'dart:developer';

import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:dio/dio.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductRepository {
  late final RestClient _client;

  ProductRepository(Map<String, dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }

  Future<ApiResponse> getProductById(String productId) async {
    if (productId == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }
    return await _client
        .getProductById(productId)
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
            } else
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

  Future<ApiResponse> getProductByCategory(
    String categoryId,
    int pageSize,
    int pageNumber,
  ) async {
    if (categoryId == null || pageSize == null || pageNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getProductsByCategory(categoryId, pageNumber, pageSize)
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
            } else {
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

  //-----------------

  Future<ApiResponse> getProducts(
    int pageSize,
    int pageNumber,
  ) async {
    if (pageSize == null || pageNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getProducts(pageNumber, pageSize)
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
            } else {
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
  //-----------------

  Future<ApiResponse> getSearchProducts(
      String keyWord,
      int pageSize,
      int pageNumber,
      ) async {
    if (pageSize == null || pageNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getProductsBySearch(keyWord,pageNumber, pageSize)
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
            } else {
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

  //-----------------
  //-----favorite-------
  //-----------------

  Future<ApiResponse> getFavoriteProducts(
      int pageSize,
      int pageNumber,
      ) async {
    if (pageSize == null || pageNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getFavoriteProducts(pageNumber, pageSize)
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
            } else {
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
  //-----------------

  Future<ApiResponse> addProductToFav(
      String productId,

      ) async {
    if (productId == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .addProductToFav(productId)
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
            } else {
           errorMessage = res.data['message'];
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

  Future<ApiResponse> deleteProductFromFav(
      String productId
      ) async {
    if (productId == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .deleteProductFromFav(productId)
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
            } else {
              errorMessage = res.data['message'];
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
