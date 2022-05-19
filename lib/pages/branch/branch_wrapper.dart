 import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';

/*<BranchListResponseModel>*/ getListData() async {
Map<String, dynamic> headerMap = await getHeaderMap();
String companyId = await PreferencesHelper.getUserID;

BranchRepository branchRepository = BranchRepository(headerMap);

ApiResponse apiResponse = await branchRepository.getAllBranch(companyId);

if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
BranchListResponseModel? responseModel =
BranchListResponseModel.fromJson(apiResponse.result);

//cities = responseModel.cities!;
print(responseModel.branches.toString());
PreferencesHelper.saveBranchesList(responseModel.branches!);
  PreferencesHelper.saveCitiesList(responseModel.cities!);

return responseModel.branches;
} else {
throw ExceptionHelper(apiResponse.message);
}
}