import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/alret_dialog.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/pages/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isBtnEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo:
      /********
       *
       * design problems:
       * height of card  , width of main column ,place of btn
       * *********/
      backgroundColor: CustomColors().backgroundColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: CardDesign.largeCardDesign(),
          ),
          SizedBox(
            height: 50,
          ),
          brandNameMiddle(),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(top: 250, left: 60),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: CustomColors().blackColor,
                        fontWeight: FontWeight.bold),
                    decoration:
                        textFieldDecorationWithIcon(LocaleKeys.email.tr(), Icons.email),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
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
                  height: 50,
                ),
                Container(
                    height: 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "myRoute");
                      },
                      child: Text(LocaleKeys.forget_pass.tr(),
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor)),
                    )),
                Container(
                    height: 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpPage();
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.new_user.tr(),
                              style:
                                  TextStyle(color: CustomColors().blackColor)),
                          Text(LocaleKeys.create_account.tr(),
                              style: TextStyle(
                                  color: CustomColors().primaryGreenColor))
                        ],
                      ),
                    )),
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: MaterialButton(
                      onPressed: () {
                        if(isBtnEnabled)
                          logIn();
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(
                          LocaleKeys.log_in.tr(), CustomColors().primaryWhiteColor),
                      color: CustomColors().primaryGreenColor,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }



  void showErrorDialog(String txt){
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => showMessageDialog(context, LocaleKeys.error.tr(),txt));

  }

  void logIn() {

    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());
      return;
    }

    if(isValidEmail(emailController.value.text) == false){
      showErrorDialog(LocaleKeys.email_not_valid.tr());
      return;
    }


    if (passController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    isBtnEnabled = false;

    print('continue log in ');

  }
}
