import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/repository/register_repository.dart';
import 'package:khudrah_companies/pages/reset_password/reset_password_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:easy_localization/easy_localization.dart';
class EnterCodePage extends StatefulWidget {
  final String userEmail;
  const EnterCodePage({Key? key,required this.userEmail}) : super(key: key);

  @override
  _EnterCodePageState createState() => _EnterCodePageState();

}


class _EnterCodePageState extends State<EnterCodePage> {
  int numberOfSecToWait = 120;
  String code = '1234'; //'get this code from DB here ';
  final TextEditingController controller = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  StreamController<int> _events = new StreamController<int>();


  @override
  void initState() {
    super.initState();

    numberOfSecToWait = 120;
    _events.add(numberOfSecToWait);
    int _counter = numberOfSecToWait;

    startTimer(_counter, _events);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('code'),
      ),
      body: StreamBuilder<int>(
        stream: _events.stream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Center(

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
                  LocaleKeys.enter_code_note.tr() + '\n' ,//+ userEmail,
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

                        //// reset password
                       // resetPassword(context, code, controller, errorController);


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
                        resendCode();
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

  //-------------------

  void sendCodeToDB(){


    showLoaderDialog(context);
    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    registerRepository.sendPasswordToken('userEmail','') .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------

      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) {

        return ResetPasswordPage();
      }));
    });
  }

  //-------------------
  void resendCode() {


    showLoaderDialog(context);
    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    registerRepository.forgetPassword('mmsaj000@hotmail.com') .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------

      Navigator.pop(context);
      initState();
    });
  }
  //-------------------
  void showErrorDialog(String txt) {

    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt,noPage));
  }
}
