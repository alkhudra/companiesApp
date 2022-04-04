import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/Constant/pref_cont.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/passowrd_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/helpers/pref/pref_manager.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/success_edit_profile_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/repository/edit_profile_repository.dart';
import 'package:khudrah_companies/network/repository/auth_repository.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';

import '../contact_us.dart';

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController ownNameController = TextEditingController(),
      compNameController = TextEditingController(),
      commercialNoController = TextEditingController(),
      vatNoController = TextEditingController(),
      emailController = TextEditingController(),
      phoneController = TextEditingController(),
      branchNoController = TextEditingController();

  bool isBtnEnabled = true;
  static bool isHasBranch = true, isForgetPassBtnEnabled = true;

  static String companyID = '';

  @override
  void initState() {
    super.initState();

    companyID = widget.user.id!;
    ownNameController.text = widget.user.ownerName!;
    compNameController.text = widget.user.companyName!;
    commercialNoController.text = widget.user.commercialRegistrationNo!;
    vatNoController.text = widget.user.vatNo!;
    phoneController.text = widget.user.phoneNumber!;
    emailController.text = widget.user.email!;
    branchNoController.text = widget.user.branchNumber!.toString();

    //------------
  }

  static _read() async {
    SharedPrefsManager.getString(currentUser).then((value) {
      return jsonDecode(value);
    });
    // return SharedPrefsManager.getFromJson(currentUser);

    // map ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarDesign(context, LocaleKeys.edit_profile_title.tr()),
      backgroundColor: Colors.grey[100],
      body: Container(
        alignment: Alignment.topCenter,
         margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: CustomColors().primaryWhiteColor,
        child: Column(
          children: [

            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: ownNameController,
              kbType: TextInputType.name,
              obscTxt: false,
              lbTxt:  LocaleKeys.owner_name.tr(),
              //  initValue: LocaleKeys.owner_name.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: compNameController,
              kbType: TextInputType.name,
              obscTxt: false,
              lbTxt: LocaleKeys.comp_name.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: emailController,
              kbType: TextInputType.emailAddress,
              obscTxt: false,
               lbTxt: LocaleKeys.change_email.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: phoneController,
              kbType: TextInputType.phone,
              obscTxt: false,
                lbTxt: LocaleKeys.change_phone.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: commercialNoController,
              kbType: TextInputType.number,
              obscTxt: false,
              lbTxt: LocaleKeys.commercial_no.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: vatNoController,
              kbType: TextInputType.number,
              obscTxt: false,
                 lbTxt: LocaleKeys.vat_no.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: branchNoController,
              kbType: TextInputType.number,
              obscTxt: false,
                  lbTxt: LocaleKeys.branches_no.tr(),
            ),
            greenBtn(LocaleKeys.save_changes.tr(),
                EdgeInsets.only(left: 20, right: 20, top: 20), () {
              if (isBtnEnabled) editProfileInfo();
            }),
          ],
        ),
      ),
      // endDrawer: drawerDesign(context),
    );
  }

  void editProfileInfo() async {
    if (ownNameController.value.text == '') {
      showErrorDialog(LocaleKeys.owner_required.tr());

      return;
    }

    if (compNameController.value.text == '') {
      showErrorDialog(LocaleKeys.company_required.tr());
      return;
    }

    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());

      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorDialog(LocaleKeys.email_not_valid.tr());

      return;
    }

    if (phoneController.value.text == '') {
      showErrorDialog(LocaleKeys.phone_required.tr());

      return;
    }
    if (isValidPhone(phoneController.value.text) != validPhone) {
      showErrorDialog(isValidPhone(phoneController.value.text));
      return;
    }

    if (commercialNoController.value.text == '') {
      showErrorDialog(LocaleKeys.commercial_no_required.tr());

      return;
    }
    if (commercialNoController.value.text.length != 10) {
      showErrorDialog(LocaleKeys.commercial_no_error.tr());

      return;
    }

    if (vatNoController.value.text == '') {
      showErrorDialog(LocaleKeys.vat_no_required.tr());

      return;
    }

    if (vatNoController.value.text.length != 15) {
      showErrorDialog(LocaleKeys.vat_no_error.tr());

      return;
    }
    if (branchNoController.value.text == '') {
      showErrorDialog(LocaleKeys.branches_no_required.tr());

      return;
    }
    if (branchNoController.value.text == '0') {
      showErrorDialog(LocaleKeys.branches_no_not_zero.tr());

      return;
    }

    isBtnEnabled = false;

    print('continue edit info ');

    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------

    Map<String, dynamic> headerMap = await getHeaderMap();

    ProfileRepository editProfileRepository = ProfileRepository(headerMap);
    print('company id $companyID');
    editProfileRepository
        .updateProfile(
            companyID,
            emailController.text,
            phoneController.text,
            ownNameController.text,
            compNameController.text,
            commercialNoController.text,
            vatNoController.text,
            int.parse(branchNoController.text))
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      SuccessEditProfileResponseModel model = SuccessEditProfileResponseModel.fromJson(result.result);
      Navigator.pop(context);
      showSuccessMessage(context, model.message!);

      PreferencesHelper.setUser(model.user!);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        //replace with dashboard
        return DashboardPage();
      }));
    });
  }

  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }
}
