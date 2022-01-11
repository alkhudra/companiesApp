import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

import 'contact_us.dart';
import 'edit_profile.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  String email='ALKhadra@gmail.com' , phone='+966554878942' , whatsApp = '+966590803061';
  double lat =0.0,lng=0.0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      // backgroundColor: CustomColors().grayColor,
      appBar: appBarDesign(context, LocaleKeys.contact_us.tr()),
      body: Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: CustomColors().primaryWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: brandName(100.0, 100.0, 22.0),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('phone');
                          directToPhoneCall(phone);
                        },
                        child: Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              width: scWidth*0.17,
                              height: scHeight*0.13,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: CustomColors().darkBlueColor.withOpacity(0.8),
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              width: scWidth*0.4,
                              child: Text(
                                phone,
                                style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('email');
                          sendMail(email);
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(left: 10),
                              width: scWidth*0.17,
                              height: scHeight*0.13,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(
                                Icons.alternate_email_outlined,
                                color: CustomColors().darkBlueColor,
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              width: scWidth*0.4,
                              child: Text(
                                email,
                                style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: scHeight/16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print('whats');
                          openWhatsApp(whatsApp);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              width: scWidth*0.17,
                              height: scHeight*0.13,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(
                                Icons.sms_outlined,
                                color: CustomColors().darkBlueColor,
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              width: scWidth*0.4,
                              child: Text(
                                whatsApp,
                                style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('location');
                          openMap(lat,lng);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              width: scWidth*0.17,
                              height: scHeight*0.13,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(
                                Icons.fmd_good_sharp,
                                color: CustomColors().darkBlueColor,
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              width: scWidth*0.4,
                              child: Text(
                                'Our Location',
                                style: TextStyle(
                                    color: CustomColors().darkBlueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      endDrawer: drawerDesign(context),
    );
  }
}