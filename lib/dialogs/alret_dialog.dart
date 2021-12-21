import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/pages/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

Widget showMessageDialog(BuildContext context, String title, String txt) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      // backgroundColor: CustomColors().cardBackgroundColor1,
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        messageDialogBtns(context),
      ],
    );
  } else {
    return AlertDialog(
      // backgroundColor: CustomColors().cardBackgroundColor1,
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
      actions: [
        messageDialogBtns(context),
      ],
    );
  }
}

FlatButton messageDialogBtns(BuildContext context) {
  return FlatButton(
    textColor: CustomColors().primaryGreenColor,
    onPressed: () {
      Navigator.pop(context, 'cancel');
    },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

////--------------------------
/*
Widget showTextFieldDialog(BuildContext context, String title) {
  final TextEditingController controller = TextEditingController();

  String errorMessage = '';
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Column(
        children: [
          CupertinoTextField(
            keyboardType: TextInputType.emailAddress,
            placeholder: LocaleKeys.enter_email.tr(),
            controller: controller,
          ),
          if (controller.text != '' && !isValidEmail(controller.text))
            Text(errorMessage),
        ],
      ),
      actions: [
        FlatButton(
          textColor: CustomColors().primaryGreenColor,
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          textColor: CustomColors().primaryGreenColor,
          onPressed: () {
            //todo: edit with setState
            if (controller.text != '' && isValidEmail(controller.text))
              errorMessage = LocaleKeys.email_not_valid.tr();
            else
              Navigator.pop(context, controller.text);
          },
          child: Text(
            LocaleKeys.send_code.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )

        //  txtFieldDialogBtns(context, controller.text, LocaleKeys.continue_btn.tr()),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: LocaleKeys.enter_email.tr()),
        controller: controller,
      ),
      actions: [
        FlatButton(
          textColor: CustomColors().primaryGreenColor,
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        //  txtFieldDialogBtns(context,controller.text , LocaleKeys.continue_btn.tr())
        FlatButton(
          textColor: CustomColors().primaryGreenColor,
          onPressed: () {
            Navigator.pop(context, controller.text);
          },
          child: Text(
            LocaleKeys.send_code.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
*/
////---------------------------
Widget showAuthPinDialog(BuildContext context, String userEmail) {
  String code = '1234'; //'get this code from DB here ';
  final TextEditingController controller = TextEditingController();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 450.0,
      width: CardDesign.cardsWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            LocaleKeys.enter_code.tr(),
            style: TextStyle(
              fontSize: 20,
              color: CustomColors().darkBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: CustomColors().primaryGreenColor,
                fontWeight: FontWeight.bold,
              ),
              length: 4,
              // obscureText: true,
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                inactiveFillColor: CustomColors().primaryWhiteColor,
                selectedFillColor: CustomColors().primaryGreenColor,
                shape: PinCodeFieldShape.box,
                inactiveColor: CustomColors().primaryGreenColor,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: CustomColors().primaryWhiteColor,
              ),
              cursorColor: CustomColors().primaryGreenColor,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: controller,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: CustomColors().blackColor,
                  blurRadius: 5,
                )
              ],
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              onChanged: (String value) {
                print(value);
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 30,
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              LocaleKeys.auth_note.tr(),
              style: TextStyle(
                  color: CustomColors().primaryGreenColor, fontSize: 15.0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: ButtonsDesign.buttonsHeight,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: MaterialButton(
                onPressed: () {
                  if (controller.text != '' && controller.text == code) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  }
                },
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(
                    LocaleKeys.verify.tr(), CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ))
        ],
      ),
    ),
  );
}

////---------------------------
Widget showPinDialog(BuildContext context, String userEmail, bool newUser) {
  String code = '1234'; //'get this code from DB here ';
  final TextEditingController controller = TextEditingController();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 450.0,
      width: CardDesign.cardsWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            LocaleKeys.enter_code.tr(),
            style: TextStyle(
              fontSize: 20,
              color: CustomColors().darkBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: CustomColors().primaryGreenColor,
                fontWeight: FontWeight.bold,
              ),
              length: 4,
              // obscureText: true,
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                inactiveFillColor: CustomColors().primaryWhiteColor,
                selectedFillColor: CustomColors().primaryGreenColor,
                shape: PinCodeFieldShape.box,
                inactiveColor: CustomColors().primaryGreenColor,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: CustomColors().primaryWhiteColor,
              ),
              cursorColor: CustomColors().primaryGreenColor,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: controller,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: CustomColors().blackColor,
                  blurRadius: 5,
                )
              ],
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              onChanged: (String value) {
                print(value);
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 30,
            padding: EdgeInsets.only(right: 10, left: 10),
            child: GestureDetector(
              onTap: () {
                //todo:resend code
              },
              child: Text(
                LocaleKeys.resend_code.tr(),
                style: TextStyle(
                    color: CustomColors().primaryGreenColor, fontSize: 15.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: ButtonsDesign.buttonsHeight,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: MaterialButton(
                onPressed: () {
                  if (newUser) {
                    //show auth code dialog
                    showAuthPinDialog(context , 'email');
                  } else {
                    //// reset password
                    resetPassword(context, code, controller);
                  }
                },
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(
                    LocaleKeys.verify.tr(), CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ))
        ],
      ),
    ),
  );
}

//-----
void resetPassword(
    BuildContext context, String code, TextEditingController controller) {
  //todo: verify
  if (code == controller.text) {
    Navigator.pop(context);

    showDialog(
        builder: (BuildContext context) => showResetPasswordDialog(context),
        context: context);
  }
}
////---------------------------

Widget showResetPasswordDialog(BuildContext context) {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: CardDesign.cardsHeight,
      width: CardDesign.cardsWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            LocaleKeys.reset_password.tr(),
            style: TextStyle(
              fontSize: 20,
              color: CustomColors().darkBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.bold),
              decoration: textFieldDecorationWithIcon(
                  LocaleKeys.password.tr(), Icons.lock_outline),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: confirmPassController,
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.bold),
              decoration: textFieldDecorationWithIcon(
                  LocaleKeys.confirm_pass.tr(), Icons.lock_outline),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
              height: ButtonsDesign.buttonsHeight,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: MaterialButton(
                onPressed: () {
                  if (passController.text != '' &&
                      confirmPassController.text != '') {
                    if (passController.text != confirmPassController.text) {
                      //todo : send new pass to db and send to home
                    }
                  }
                },
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(LocaleKeys.reset_password.tr(),
                    CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ))
        ],
      ),
    ),
  );
}
