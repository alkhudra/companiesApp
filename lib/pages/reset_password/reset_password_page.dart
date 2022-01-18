import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/app_bar_txt.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/repository/register_repository.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';

class ResetPasswordPage extends StatefulWidget {
  final Map<String ,String> dataMap;
  const ResetPasswordPage({Key? key , required this.dataMap}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isBtnEnabled= true;
  @override
  Widget build(BuildContext context) {

    Size? size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.reset_password.tr()),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors().backgroundColor,
      body: Stack(
        children: [
          Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 2.1,
            decoration: CardDesign.largeCardDesign(),
          ),
          brandNameMiddle(),
          Container(
            margin: EdgeInsets.only(
                top: scHeight * 0.13,
                right: scWidth * 0.1,
                left: scWidth * 0.1),
            // padding: EdgeInsets.symmetric(horizontal: scWidth/9, vertical: scHeight/5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: scHeight*0.19,),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: passController,
                  kbType: TextInputType.visiblePassword,
                  obscTxt: false,
                  lbTxt: LocaleKeys.password.tr(),
                ),
                SizedBox(height: 3,),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: confirmPassController,
                  kbType: TextInputType.visiblePassword,
                  obscTxt: false,
                  lbTxt: LocaleKeys.confirm_pass.tr(),
                ),

                SizedBox(
                  // height: scHeight*0.15,
                ),
                //reset button
                Container(
                  alignment: Alignment.bottomCenter,
                  height: ButtonsDesign.buttonsHeight,
                  margin: EdgeInsets.only(left: 50, right: 50, top: scHeight/9.5),
                  child: MaterialButton(
                    onPressed: () {

                      if(isBtnEnabled)
                        startReset();

                    },
                    shape: StadiumBorder(),
                    child: ButtonsDesign.buttonsText(LocaleKeys.reset_password.tr(),
                        CustomColors().primaryWhiteColor),
                    color: CustomColors().primaryGreenColor,
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

  void startReset
      () {

    if (passController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    if (confirmPassController.value.text == '') {
      showErrorDialog(LocaleKeys.confirm_pass_required.tr());
      return;
    }


    if (passController.value.text != confirmPassController.value.text) {
      showErrorDialog(LocaleKeys.not_match_pass.tr());
      return;
    }

    isBtnEnabled = false;


    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    String email = widget.dataMap.values.first;
    String token = widget.dataMap.values.last;

    registerRepository.resetPassword(email, passController.text,confirmPassController.text,token) .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      Navigator.pop(context);

      MessageResponseModel model = MessageResponseModel.fromJson( result.result);


      if(model != null)
      showSuccessDialog(context, model.message!);


    });
  }


  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt,noPage));
  }

  showSuccessDialog(BuildContext context,String message) {

    //todo:make user can not go back
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.pass_changed_done.tr(),message ,mainRoute));

  }

}
