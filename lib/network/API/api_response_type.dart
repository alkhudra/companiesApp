import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

enum ApiResponseType {
  OK,
  BadRequest,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  Conflict,
  InternalServerError,
  other,
}

extension ApiErrorTypeExtension on ApiResponseType {
  get code {
    switch (this) {
      case ApiResponseType.OK:
        return 200;
      case ApiResponseType.BadRequest:
        return 400;
      case ApiResponseType.Forbidden:
        return 403;
      case ApiResponseType.NotFound:
        return 404;
      case ApiResponseType.MethodNotAllowed:
        return 405;
      case ApiResponseType.Conflict:
        return 409;
      case ApiResponseType.InternalServerError:
        return 500;
      default:
        return null;
    }
  }

  get message {
    switch (this) {
      case ApiResponseType.OK:
        return "";
      case ApiResponseType.BadRequest:

      case ApiResponseType.Forbidden:

      case ApiResponseType.NotFound:

      case ApiResponseType.MethodNotAllowed:

      case ApiResponseType.Conflict:

      case ApiResponseType.InternalServerError:
        return LocaleKeys.wrong_error.tr();
      default:
        return LocaleKeys.wrong_error.tr();
    }
  }
}
