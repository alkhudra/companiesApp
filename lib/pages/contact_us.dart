import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/helpers/contact_helper.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  String email='Alkhadra@gmail.com' , phone='+966554878942' , whats = '+966554878942' , twit = 'Twitter';
  double lat =0.0,lng=0.0;
  bool _customTileExpanded = false;       
                      
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBarDesign(context, LocaleKeys.contact_us.tr()),
      body:/* Container(
        // margin: EdgeInsets.only(top: 5),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: CustomColors().primaryWhiteColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          // ),
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
                //Phone number
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
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            phone,
                            style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Email
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
                          maxLines: 1,
                          style: TextStyle(
                              color: CustomColors().darkBlueColor,
                              fontSize: 15,
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
                //Social Media
                GestureDetector(
                  onTap: (){
                    print('social');

                    openWhatsApp(phone);
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
                          FontAwesomeIcons.hashtag,
                          color: CustomColors().darkBlueColor,
                          size: 30,
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
                          // LocaleKeys.whats_app.tr(),
                          LocaleKeys.social_media.tr(),
                          maxLines: 1,
                          style: TextStyle(
                              color: CustomColors().darkBlueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                //Location
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
                          LocaleKeys.our_location.tr(),
                          style: TextStyle(
                              color: CustomColors().darkBlueColor,
                              fontSize: 15,
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
      ),*/
      
      ListView(
        children: [
          ListTile(
            minVerticalPadding: 20,
            title: brandName(100.0, 100.0, 22.0),
          ),
          SizedBox(height: 10,),
          //phone
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: GestureDetector(
                onTap: () {
                  print('phone');
                  directToPhoneCall(phone);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      width: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: scWidth*0.4,
                      child: Text(
                        phone,
                        style: TextStyle(
                            color: CustomColors().darkBlueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Divider(
          //   thickness: 2,
          //   color: CustomColors().grayColor,
          //   indent: 80,
          //   endIndent: 80,
          // ),
          //email
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              title: GestureDetector(
                onTap: () {
                  print('email');
                  sendMail(email);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      width: 15,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: scWidth*0.4,
                      child: Text(
                        email,
                        style: TextStyle(
                            color: CustomColors().darkBlueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //social media
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 20,),
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
                      FontAwesomeIcons.hashtag,
                      color: CustomColors().darkBlueColor
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    width: scWidth*0.4,
                    child: Text(
                      LocaleKeys.social_media.tr(),
                      style: TextStyle(
                          color: CustomColors().darkBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              children: [
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      print('whats');
                      openWhatsApp(phone);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          width: scWidth*0.15,
                          height: scHeight*0.12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/product_icon.png'),
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.whatsapp,
                            color: CustomColors().darkBlueColor
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          width: scWidth*0.4,
                          child: Text(
                            LocaleKeys.whats_app.tr(),
                            style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //twitter
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      print('twitter');
                      openTwitterApp('imanalMohd000');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          width: scWidth*0.15,
                          height: scHeight*0.12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/product_icon.png'),
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: CustomColors().darkBlueColor
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          width: scWidth*0.4,
                          child: Text(
                            //TODO: replace text with twitter handle
                            LocaleKeys.twit,
                            style: TextStyle(
                                color: CustomColors().darkBlueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              trailing: Container(
                padding: EdgeInsets.only(top: 20),
                height: double.infinity,
                child: Icon(
                _customTileExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,
                ),
              ),
              onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
            ),
          ),
          //location
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: ListTile(
              title: GestureDetector(
                onTap: () {
                  print('location');
                  openMap(lat,lng);
                },
                child: Row(
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
                      width: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: scWidth*0.4,
                      child: Text(
                        'Our Location',
                        style: TextStyle(
                            color: CustomColors().darkBlueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    /*  Container(
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
                //Phone number
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                //Email
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
                              fontSize: 15,
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
                //Social Media
                GestureDetector(
                  onTap: (){
                    print('social');
                    openWhatsApp(phone);
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
                          FontAwesomeIcons.hashtag,
                          color: CustomColors().darkBlueColor
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
                          whats,
                          style: TextStyle(
                              color: CustomColors().darkBlueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                //Location
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
                              fontSize: 15,
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
      ),*/
      endDrawer: drawerDesign(context),
    );
  }
}