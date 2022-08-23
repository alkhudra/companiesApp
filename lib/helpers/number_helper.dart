import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

String currency = LocaleKeys.sar.tr();

String getTextWithCurrency(num value) {
  String num = convertTo2Decimals(value);
  String numString =
      '$num'.length > 7 ? '${num.toString().substring(0, 7)} ...' : '$num';
  return ' $numString ' + LocaleKeys.sar.tr();
}

String getTextWithPercentage(num value) {
  return ' $value %';
}

//---------------
convertTo2Decimals(num number) {
  return number.toStringAsFixed(2);
}

//---------------
