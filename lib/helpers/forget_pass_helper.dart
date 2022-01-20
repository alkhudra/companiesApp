import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/forget_password_response_model.dart';
import 'package:khudrah_companies/network/network_helper.dart';
import 'package:khudrah_companies/network/repository/register_repository.dart';
import 'package:khudrah_companies/pages/reset_password/enter_code_page.dart';
import 'package:easy_localization/easy_localization.dart';

void forgetPasswordProcess(
    BuildContext context, String userEmail, bool isForgetPassBtnEnabled) async{
  if (userEmail != '') {
    isForgetPassBtnEnabled = false;

    print(userEmail);
    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getAuthHeaderMap();

    AuthRepository registerRepository = AuthRepository(headerMap);
    registerRepository.forgetPassword(userEmail).then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        isForgetPassBtnEnabled = true;
        showErrorMessageDialog(context, result.message);
        return;
      }

      //-------- success response ---------

      ForgetPasswordResponseModel model = result.result;
      if (model.code == '') {
        Navigator.pop(context);
        isForgetPassBtnEnabled = true;

        showErrorMessageDialog(context, LocaleKeys.wrong_email.tr());
        return;
      }
      Navigator.pop(context);
      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        isForgetPassBtnEnabled = true;
        return EnterCodePage(
          userEmail: userEmail,
          code: model.code!,
        );
      }));
    });
  }
}
