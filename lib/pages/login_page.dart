import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        textFieldDecorationWithIcon('Email', Icons.email),
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
                        'Password', Icons.lock_outline),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "myRoute");
                      },
                      child: Text("Forget Password?",
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                    height: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "myRoute");
                      },
                      child: Text("create new account?",
                          style: TextStyle(
                              color: CustomColors().primaryGreenColor,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 90, right: 90, top: 10),
                    child: MaterialButton(
                      onPressed: () {
                        //  onLanguageButtonPressed('ar');
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(
                          'sign in', CustomColors().primaryWhiteColor),
                      color: CustomColors().primaryGreenColor,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
