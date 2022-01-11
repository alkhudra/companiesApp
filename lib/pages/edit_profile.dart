import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/passowrd_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/info_correcter_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/repository/edit_profile_repository.dart';
import 'package:khudrah_companies/network/repository/register_repository.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';

import 'contact_us.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController ownNameController,
      compNameController,
      commercialNoController,
      emailController,
      phoneController,
      branchNoController;

  bool isBtnEnabled = true;
  static bool isHasBranch = true,isForgetPassBtnEnabled = true;

  static String companyName = '',
      ownerName= '',
      email= '',
      phoneNumber= '',
      commercialNo= '',
      branchNo= '',
      companyID= '';

  @override
  void initState() {
    super.initState();
    //companyID = PreferencesHelper.getCompanyID()!;
    //------------

   // getUserInfo();

    //------------
    ownNameController = TextEditingController(text: ownerName);
    compNameController = TextEditingController(text: companyName);
    commercialNoController = TextEditingController(text: commercialNo);
    emailController = TextEditingController(text: email);
    phoneController = TextEditingController(text: phoneNumber);
    branchNoController = TextEditingController(text: branchNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.edit_profile_title.tr()),
      backgroundColor: Colors.grey[100],
      body: Container(
          alignment: Alignment.topCenter,
          // margin: EdgeInsets.only(top: 100),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: CustomColors().primaryWhiteColor,
          child: Column(
            children: [
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 20,
                horMarg: 20,
                controller: ownNameController,
                kbType: TextInputType.name,
                //  initValue: LocaleKeys.owner_name.tr(),
              ),
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 0,
                horMarg: 20,
                controller: compNameController,
                kbType: TextInputType.name,
                //initValue: LocaleKeys.comp_name.tr(),
              ),
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 20,
                horMarg: 20,
                controller: emailController,
                kbType: TextInputType.emailAddress,
                // initValue: LocaleKeys.change_email.tr(),
              ),
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 0,
                horMarg: 20,
                controller: phoneController,
                kbType: TextInputType.phone,
                //  initValue: LocaleKeys.change_phone.tr(),
              ),
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 20,
                horMarg: 20,
                controller: commercialNoController,
                kbType: TextInputType.number,
                //   initValue: LocaleKeys.commercial_no.tr(),
              ),
              TextFieldDesign.editTextFieldStyle(
                context: context,
                verMarg: 0,
                horMarg: 20,
                controller: branchNoController,
                kbType: TextInputType.number,
                //    initValue: LocaleKeys.branches_no.tr(),
              ),
              greenBtn(LocaleKeys.save_changes.tr(),
                  EdgeInsets.only(left: 20, right: 20, top: 20), () {
                if (isBtnEnabled) editProfileInfo();
              }),
              greenBtn(LocaleKeys.reset_password.tr(),
                  EdgeInsets.only(left: 20, right: 20, top: 20), () {
                if(isForgetPassBtnEnabled)
                    resetPasswordProcess();
                  }),
            ],
          ),
        ),
      endDrawer: drawerDesign(context),
    );
  }

  void editProfileInfo() {
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

    EditProfileRepository editProfileRepository = EditProfileRepository();
    editProfileRepository
        .updateProfile(
            companyID,
            emailController.text,
            phoneController.text,
            ownNameController.text,
            compNameController.text,
            commercialNoController.text,
            int.parse(branchNoController.text))
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      MessageResponseModel model = result.result;
      Navigator.pop(context);
      showSuccessMessage(context, model.message!);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        //replace with dashboard
        return DashboardPage(isHasBranch: isHasBranch);
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

  void getUserInfo() {
    print('get user info ');
    //----------show progress----------------

    showLoaderDialog(context);

    //----------start api ----------------

    RegisterRepository registerRepository = RegisterRepository();
    registerRepository
        .getUserInfo(
      companyID,
    )
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      SuccessLoginResponseModel model = result.result;

      if (model.user != null) {
        User user = model.user!;
        email = user.email!;
        ownerName = user.ownerName!;
        companyName = user.companyName!;
        commercialNo = user.commercialRegistrationNo!;
        branchNo = user.branchNumber!.toString();
        phoneNumber = user.phoneNumber!;
        isHasBranch = user.branches!.isNotEmpty;

        Navigator.pop(context);
      }
    });
  }


  //------------------------------
  void resetPasswordProcess() {
    showDialog(
        builder: (BuildContext context) =>
            showEnterEmailDialog(context,isForgetPassBtnEnabled),
        context: context);
  }
}
