import 'package:khudrah_companies/network/repository/home_repository.dart';

import 'API/api_response.dart';
import 'API/api_response_type.dart';
import 'helper/network_helper.dart';
import 'models/home/home_success_response_model.dart';

class HomePageProvider {
  static late HomeSuccessResponseModel response;

  factory HomePageProvider() => HomePageProvider._internal();
  HomePageProvider._internal();
  static Future<void> fetchData() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    HomeRepository homeRepository = HomeRepository(headerMap);

    ApiResponse apiResponse = await homeRepository.getHomeInfo();
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      //  response = apiResponse.result;
      response = HomeSuccessResponseModel.fromJson(apiResponse.result);
    } else {
      response = apiResponse.message;
      throw Exception(apiResponse.message);
    }
  }
}
