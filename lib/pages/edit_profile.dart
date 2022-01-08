
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/language_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

import 'contact_us.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

final TextEditingController ownNameController = TextEditingController();
final TextEditingController compNameController = TextEditingController();
final TextEditingController drvNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.edit_profile_title.tr(), style: TextStyle(
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
                alignment: Alignment.topCenter,
                // margin: EdgeInsets.only(top: 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: CustomColors().primaryWhiteColor,
                child: Column(
                  children: [
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.owner_name.tr(),
                      obscTxt: false,
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 0,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.comp_name.tr(),
                      obscTxt: false,
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.change_email.tr(),
                      obscTxt: false,
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 0,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.change_phone.tr(),
                      obscTxt: false,
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.password.tr(),
                      obscTxt: true,
                    ),
                    SizedBox(height: 50,),
                    Container(
                      // margin: EdgeInsets.fromLTRB(80, 470, 80, 310),
                      width: MediaQuery.of(context).size.width/1.15,
                      height: MediaQuery.of(context).size.height/15,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          fixedSize: Size(250.0, 70.0),
                          backgroundColor: CustomColors().primaryGreenColor,
                        ),
                        onPressed:() {
                          //disable button after first click, to avoid 
                          // sending two requests to DB
                        },
                        child: Text(LocaleKeys.save_changes.tr(), style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                      ),
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
                        color: CustomColors().contactBG,
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
                    builder: (context) => EditProfile()
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