import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController brunchesController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController commercialNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90, left: 30, right: 30),
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 0.97,
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
              margin: EdgeInsets.only(top: 250, left: 40, right: 30),
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    child: TextField(
                      controller: ownerController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Owner Name'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: companyNameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Company Name'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Email'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Phone'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: commercialNoController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration:
                          textFieldDecoration('Commercial Registration No'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: brunchesController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('How Many Brunches ?'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/

                  Container(
                    height: 60,
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Password'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                    height: 60,
                    child: TextField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                          color: CustomColors().blackColor,
                          fontWeight: FontWeight.bold),
                      decoration: textFieldDecoration('Confirm Password'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /******/
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          //todo: go to terms
                          /*  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            }));*/
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("By tapping Sign up you accept all  ",
                                style: TextStyle(
                                    color: CustomColors().blackColor)),
                            Text("terms and condition",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )),
                  Container(
                      height: ButtonsDesign.buttonsHeight,
                      margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: MaterialButton(
                        onPressed: () {
                          continueSignUp();
                        },
                        shape: StadiumBorder(),
                        child: ButtonsDesign.buttonsText(
                            'continue', CustomColors().primaryWhiteColor),
                        color: CustomColors().primaryGreenColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void continueSignUp() {
    if (ownerController.value.text == '') {
      print('owner name');
      return;
    }

    if (companyNameController.value.text == '') {
      print('owner name');
      return;
    }

    if (emailController.value.text == '') {
      print('owner name');
      return;
    }

    if(isValidEmail(emailController.value.text) == false){
      print('not valid email');
      return;
    }

    if (phoneController.value.text == '') {
      print('owner name');
      return;
    }
    if (isValidPhone(phoneController.value.text) != validPhone) {
      print(isValidPhone(phoneController.value.text));
      return;
    }

    if (commercialNoController.value.text == '') {
      print('owner name');
      return;
    }

    if (brunchesController.value.text == '') {
      print('owner name');
      return;
    }

    if (passwordController.value.text == '') {
      print('owner name');
      return;
    }

    if (confirmPasswordController.value.text == '') {
      print('owner name');
      return;
    }

    if (passwordController.value.text != confirmPasswordController.value.text) {
      print('not match pass ');
      return;

      //// continue sign
    }
  }
}
