
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/pages/language_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

import 'contact_us.dart';
import 'edit_profile.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

final TextEditingController ownNameController = TextEditingController();
final TextEditingController compNameController = TextEditingController();
final TextEditingController drvNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors().primaryGreenColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('images/grapevector.png'),
                  ),
                ],
              ),
              expandedHeight: 160,
              elevation: 0.0,
              backgroundColor: CustomColors().primaryGreenColor,
              iconTheme: IconThemeData(color: CustomColors().primaryWhiteColor),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: CustomColors().primaryWhiteColor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
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
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: 250, top: 30),
                    //   child: Text(LocaleKeys.contact_us.tr(), 
                    //   style: TextStyle(color: kDarkBlue, fontSize: 23, fontWeight: FontWeight.w700),),
                    // ),
                    SizedBox(height: 30,),
                    Container(
                      child: brandName(100.0, 100.0, 22.0),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.phone, color: CustomColors().blackColor, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 55),
                              child: Text('+966554878942', style: TextStyle(
                                color: CustomColors().blackColor,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(width: 35,),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.mail_outline, color: CustomColors().blackColor, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('ALKhadra@gmail.com', style: TextStyle(
                                color: CustomColors().blackColor,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.sms_outlined, color: CustomColors().blackColor, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 55),
                              child: Text('+966554878942', style: TextStyle(
                                color: CustomColors().blackColor,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(width: 35,),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 60),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.fmd_good_sharp, color: CustomColors().blackColor, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 60),
                              child: Text('Our Location', style: TextStyle(
                                color: CustomColors().blackColor,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                width: 100,
                height: 300,
                decoration: BoxDecoration(
                  color: CustomColors().primaryGreenColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 40),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/male_avatar.png'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      //TODO: replace with company variable from DB
                      child: Text('Company Name', style: TextStyle(
                        color: CustomColors().primaryWhiteColor,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      //TODO: replace with email variable from DB
                      child: Text('company@email.com', style: TextStyle(
                        color: CustomColors().primaryWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EditProfile())
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CustomColors().primaryWhiteColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(child: Text(LocaleKeys.edit_profile.tr(),
                        style: TextStyle(color: CustomColors().primaryGreenColor,
                        fontWeight: FontWeight.w700),)),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors().languageBG
                      ),
                      child: Icon(Icons.language, color: CustomColors().language,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.languages.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => LanguagePage()
                    ),
                  );
                },
              ),
              Divider(
                thickness: 2.5,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors().contactBG
                      ),
                      child: Icon(Icons.verified_user_rounded, color: CustomColors().contact,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ContactUs()
                    ),
                  );
                },
              ),
              Divider(
                thickness: 2.5,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors().logOutBG
                      ),
                      child: Icon(Icons.logout, color: CustomColors().logOut,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.log_out.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ContactUs()
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}