import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/add_brunches_page.dart';
import 'package:khudrah_companies/pages/login_page.dart';
import 'package:khudrah_companies/pages/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


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
                return false;
              },
              onChanged: (String value) {
                print(value);
              },
            ),
          ),

          SizedBox(
            height: 10,
          )
          ,
          Container(

            alignment: Alignment.center,
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
                      return AddBranchesPage();
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
  int numberOfSecToWait = 120;
  String code = '1234'; //'get this code from DB here ';
  final TextEditingController controller = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  StreamController<int> _events = new StreamController<int>();
  _events.add(numberOfSecToWait);
  int _counter = numberOfSecToWait;

  startTimer(_counter, _events);

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here

    child: StreamBuilder<int>(
      stream: _events.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Container(
          height: CardDesign.cardsHeight,
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
              Text(
                LocaleKeys.enter_code_note.tr() + '\n' + userEmail,
                style: TextStyle(
                  fontSize: 15,
                  color: CustomColors().primaryGreenColor,
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

                  errorAnimationController: errorController,
                  pinTheme: PinTheme(
                    errorBorderColor: CustomColors().likeColor,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    return false;
                  },
                  onChanged: (String value) {},
                  onCompleted: (v) {
                    if (newUser) {
                      //show auth code dialog
                      showDialog(
                          builder: (BuildContext context ) =>
                              showAuthPinDialog(context, userEmail),
                          context: context);

                    } else {
                      //// reset password
                      resetPassword(context, code, controller, errorController);

                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10, left: 10),
                child:  Text(
                 LocaleKeys.resend_code_note.tr()+'\n',
                  style: TextStyle(
                      color: CustomColors().primaryGreenColor,
                      fontSize: 15.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    //todo:resend code

                    //you can tap if only finish timer
                    if(snapshot.data.toString() == '0')
                      print(snapshot.data.toString());
                  },
                  child: Text(
                    (snapshot.data.toString() != '0')
                        ? snapshot.data.toString()
                        : LocaleKeys.resend_code.tr(),
                    style: TextStyle(
                        color: CustomColors().primaryGreenColor,
                        fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    ),
  );
}

void startTimer(int _counter, StreamController<int> _events) {
  Timer.periodic(Duration(seconds: 1), (timer) {
    //setState(() {
    (_counter > 0) ? _counter-- : timer.cancel();
    //});
    print(_counter);
    _events.add(_counter);
  });
}



//-----
void resetPassword(
    BuildContext context,
    String code,
    TextEditingController controller,
    StreamController<ErrorAnimationType> errorController) {
  //todo: verify
  if (code == controller.text) {
    Navigator.pop(context);

    showDialog(
        builder: (BuildContext context) => showResetPasswordDialog(context),
        context: context);
  } else
    errorController.add(ErrorAnimationType.shake);
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
            child: TextFormField(
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
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (passController.text.isEmpty) {
                  return LocaleKeys.pass_required.tr();
                }
                if (confirmPassController.text == '') {
                  return LocaleKeys.confirm_pass_required.tr();
                }
                if (passController.text != confirmPassController.text) {
                  return LocaleKeys.not_match_pass.tr();
                }
              },
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
