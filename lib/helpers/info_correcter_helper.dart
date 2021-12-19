import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

bool isValidEmail(String email) {
  if (email.contains('@'))
    return true;
  else
    return false;
}

String isValidPhone(String phone) {
  if (phone.length != 10) {
    return LocaleKeys.phone_length_error.tr();
  } else if (!phone.startsWith('05')) {
    return LocaleKeys.phone_start_error.tr();
  } else
    return validPhone;
}
