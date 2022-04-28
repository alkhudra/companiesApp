import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/network/API/api_config.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';
import 'package:khudrah_companies/network/models/orders/order_items.dart';

class OrderRepository {
  late final RestClient _client;

  OrderRepository(Map<String, dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }

  //-----------------------------------

  Future<ApiResponse> getAllOrders(
    int pageSize,
    int pageNumber,
  ) async {
    if (pageSize == null || pageNumber == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getOrders(pageSize, pageNumber)
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

  //-----------------------------------

  Future<ApiResponse> getOrderById(
      int orderId,

      ) async {
    if (orderId == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getOrderById(orderId)
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
  //-----------------------------------
  Future<ApiResponse> submitOrder({
    List<SubmitOrderItems>? orderItem,
    String? companyId,
    String? branchId,
    String? paymentType,
    bool? hasPaid,
    num? totalOrderPrice,
    num? totalNetOrderPrice,
    num? totalOrderVAT15,
    bool? hasDiscount,
    num? discountPercentage,
    num? totalDiscount,}
  ) async {
    if (orderItem == null ||
        companyId == null ||
        branchId == null ||
        paymentType == null ||
        hasPaid == null ||
        totalOrderPrice == null ||
        totalNetOrderPrice == null ||
        totalOrderVAT15 == null ||
        hasDiscount == null ||
        discountPercentage == null ||
        totalDiscount == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "companyId": companyId,
      "branchId": branchId,
      "paymentType": paymentType,
      "hasPaid": hasPaid,
      "totalOrderPrice": totalOrderPrice,
      "totalNetOrderPrice": totalNetOrderPrice,
      "totalOrderVAT15": totalOrderVAT15,
      "hasDiscount": hasDiscount,
      "discountPercentage": discountPercentage,
      "totalDiscount": totalDiscount,
      "orderItems": orderItem
    };
    print(hashMap.toString());
    return await _client
        .submitOrder(hashMap)
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
}
