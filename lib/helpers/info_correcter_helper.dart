

import 'package:khudrah_companies/Constant/conts.dart';

bool isValidEmail(String email){
  if(email.contains('@'))
    return true;
  else return false;
}

String isValidPhone(String phone){

  if (phone.length != 10) {

    return 'phone length error ';
  }
  else if (!phone.startsWith('05') ) {

    return 'phone starts error ';

  }
  else return validPhone;

}

