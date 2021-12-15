import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/sign_up_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //todo: text design on iphone and android
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
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "myRoute");
                      },
                      child: Text("Forget Password ?",
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
                          Text("New User?  ",
                              style:
                                  TextStyle(color: CustomColors().blackColor)),
                          Text("Sign Up",
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
                        //  onLanguageButtonPressed('ar');
                        print(emailController.text.toLowerCase());
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
