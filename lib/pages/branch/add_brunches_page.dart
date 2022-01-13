import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/app_bar_txt.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/dialogs/message_dialog.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/dialogs/two_btns_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/location_helper.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/models/auth/success_login_response_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/network_helper.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/pages/pick_location_page.dart';
import 'package:khudrah_companies/pages/reset_password/enter_code_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';

class AddBranchesPage extends StatefulWidget {
  // final Map<String ,dynamic>  map ;

  const AddBranchesPage({Key? key}) : super(key: key);

  @override
  _AddBranchesPageState createState() => _AddBranchesPageState();
}

class _AddBranchesPageState extends State<AddBranchesPage> {
  final TextEditingController cityCountryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  static LatLng latLng = LatLng(0, 0);
  static String address = '';

  String addTxt = LocaleKeys.add_branch.tr();
  String editTxt = LocaleKeys.add_branch.tr();
  String barAndBtnTxt = LocaleKeys.add_branch.tr();

  bool isAddBtnEnabled = true;
  bool isPickLocationBtnEnabled = true;

// = LatLng(ksaLat,ksaLng);
  late Map<String, dynamic> alreadyUsedMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithActions(context, getBarAndBtnTxt(), () {
        backButtonClicked();
      }),
      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.add_branch_note.tr(),
                style: TextStyle(
                    fontSize: 15,
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: phoneController,
              kbType: TextInputType.phone,
              obscTxt: false,
              lbTxt: getPhoneTxt(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: zipCodeController,
              kbType: TextInputType.number,
              obscTxt: false,
              lbTxt: getZipCodeTxt(),
            ),
            TextFieldDesign.disableTextFieldStyle(
                context: context,
                verMarg: 5,
                horMarg: 0,
                controller: cityCountryController,
                kbType: TextInputType.text,
                obscTxt: false,
                lbTxt: LocaleKeys.ksa.tr(),
                enabled: false),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.add_location_note.tr(),
                style: TextStyle(
                    fontSize: 15,
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            greenBtnWithIcon(LocaleKeys.add_location.tr(), Icons.my_location,
                EdgeInsets.all(20), () {
              if (isPickLocationBtnEnabled) {
                isPickLocationBtnEnabled = false;
                addLocation();
              }
            }),
            TextFieldDesign.emptyLargeFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: addressController,
              kbType: TextInputType.multiline,
              initValue: LocaleKeys.enter_branch_address.tr(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: greenBtn(getBarAndBtnTxt(), EdgeInsets.all(20), () {
                if (isAddBtnEnabled) addBranch();
              }),
            ),
          ],
        ),
      ),
    );
  }

  //---------------------------------

  @override
  void initState() {
    super.initState();
    alreadyUsedMap = {};
    address = '';
  }

  void addLocation() async {
    // ask for permission
    LatLng userLocation;
    if (alreadyUsedMap.isEmpty) {
      userLocation = await getUserLatLng();
    } else {
      userLocation = alreadyUsedMap[branchLatLng];
    }

    directToPickLocationPage(userLocation);
    isPickLocationBtnEnabled = true;
    print(userLocation.toString());
  }

  //-------------------------------

  void directToPickLocationPage(LatLng userLocation) async {
    final addressMap =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PickLocationPage(
        userLatLng: userLocation,
      );
    }));

    if (addressMap != null) {
      alreadyUsedMap = addressMap;

      setState(() {
        address = alreadyUsedMap[branchAddress] != null
            ? alreadyUsedMap[branchAddress]
            : address;
        latLng = alreadyUsedMap[branchLatLng] != null
            ? alreadyUsedMap[branchLatLng]
            : latLng;

        addressController.text = address;
      });

      print(address);
    }
  }

  //-----------

  void addBranch() async {
    if (phoneController.value.text == '') {
      showErrorDialog(LocaleKeys.phone_required.tr());
      return;
    }

    if (phoneController.text.length != 10) {
      showErrorDialog(LocaleKeys.phone_length_error.tr());
      return;
    }
    if (!phoneController.text.startsWith('05')) {
      showErrorDialog(LocaleKeys.phone_start_error.tr());
      return;
    }

    if (zipCodeController.value.text == '') {
      showErrorDialog(LocaleKeys.zipcode_required.tr());
      return;
    }
    if (zipCodeController.text.length != 5) {
      showErrorDialog(LocaleKeys.zipcode_length_error.tr());
      return;
    }
    if (address == '') {
      showErrorDialog(LocaleKeys.address_required.tr());
      return;
    }

    isAddBtnEnabled = true;
    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getHeaderMap();

    BranchRepository branchRepository = BranchRepository(headerMap);
    String companyID = await PreferencesHelper.getUserID;
    User user = await PreferencesHelper.getUser;
    String companyName = user.companyName!;
    branchRepository
        .addNewBranch(companyID, companyName, phoneController.text, address,
            zipCodeController.text, latLng.longitude, latLng.latitude)
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        if (result.apiStatus.code == ApiResponseType.BadRequest)
          Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      address = '';
      alreadyUsedMap.clear();
      PickLocationPage.setValues();
      MessageResponseModel messageResponseModel =
          MessageResponseModel.fromJson(result.result);
      showSuccessMessage(context, messageResponseModel.message!);
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  //-------------------------
  void showErrorDialog(String txt) {
    isAddBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }
  //----UI text -------

  String getBarAndBtnTxt() {
    return addTxt;
  }

  String getPhoneTxt() {
    return LocaleKeys.enter_branch_phone.tr();
  }

  String getZipCodeTxt() {
    return LocaleKeys.enter_branch_zip_code.tr();
  }

  void backButtonClicked() {
    List<Function()> actions = [
      () {
        Navigator.pop(context);
      },
      () {
        Navigator.pop(context);
        PickLocationPage.setValues();
        address = '';
        alreadyUsedMap.clear();
        Navigator.pop(context);
      }
    ];
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => showTwoBtnDialog(
            context,
            LocaleKeys.add_branch.tr(),
            LocaleKeys.continue_add_branch_note_dialog.tr(),
            LocaleKeys.continue_btn.tr(),
            LocaleKeys.cancel.tr(),
            actions));
  }
}
