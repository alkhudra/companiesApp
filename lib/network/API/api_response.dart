import 'api_response_type.dart';

class ApiResponse {

  final ApiResponseType apiStatus;
  final dynamic result;
  final String _customMessage;


  get message {
    if (_customMessage != null && _customMessage.isNotEmpty)
      return _customMessage;
    return this.apiStatus.message;
  }

  ApiResponse(this.apiStatus, this.result, this._customMessage);

  static ApiResponseType convert(int statusCode) {
    if (statusCode == ApiResponseType.OK.code) {
      return ApiResponseType.OK;
    } else if (statusCode == ApiResponseType.BadRequest.code) {
      return ApiResponseType.BadRequest;
    } else if (statusCode == ApiResponseType.Forbidden.code) {
      return ApiResponseType.Forbidden;
    } else if (statusCode == ApiResponseType.NotFound.code) {
      return ApiResponseType.NotFound;
    } else if (statusCode == ApiResponseType.MethodNotAllowed.code) {
      return ApiResponseType.MethodNotAllowed;
    } else if (statusCode == ApiResponseType.Conflict.code) {
      return ApiResponseType.Conflict;
    } else if (statusCode == ApiResponseType.InternalServerError.code) {
      return ApiResponseType.InternalServerError;
    } else {
      return ApiResponseType.other;
    }
  }

  @override
  String toString() {
    return 'ApiResponse{apiStatus: $apiStatus, result: $result, _customMessage: $_customMessage}';
  }
}