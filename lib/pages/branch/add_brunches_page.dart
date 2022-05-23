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
import 'package:khudrah_companies/network/models/branches/branch_list_response_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:khudrah_companies/network/models/branches/success_branch_response_model.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/repository/branches_repository.dart';
import 'package:khudrah_companies/pages/pick_location_page.dart';
import 'package:khudrah_companies/pages/reset_password/enter_code_page.dart';
import 'package:khudrah_companies/provider/branch_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';

class AddBranchesPage extends StatefulWidget {
  final List<Cities> cities;

  const AddBranchesPage({Key? key, required this.cities}) : super(key: key);

  @override
  _AddBranchesPageState createState() => _AddBranchesPageState();
}

class _AddBranchesPageState extends State<AddBranchesPage> {
  static String city = ' ', address = '';

  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalIDAddressController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  static LatLng latLng = LatLng(0, 0);

  String addTxt = LocaleKeys.add_branch.tr();

  bool isAddBtnEnabled = true;
  bool isPickLocationBtnEnabled = true;

// = LatLng(ksaLat,ksaLng);
  late Map<String, dynamic> alreadyUsedMap;

  @override
  Widget build(BuildContext context) {
    String dropdownValue = getCityTxt();
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    List<String> cities = [dropdownValue];
    for (Cities c in widget.cities)
      cities.add(Provider.of<GeneralProvider>(context, listen: true)
                  .userSelectedLanguage ==
              'ar'
          ? c.arCityName!
          : c.enCityName!);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    height: 1.5,
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: nameController,
              kbType: TextInputType.name,
              obscTxt: false,
              lbTxt: getBranchName(),
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
              controller: districtController,
              kbType: TextInputType.name,
              obscTxt: false,
              lbTxt: getBranchDistrict(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: streetController,
              kbType: TextInputType.name,
              obscTxt: false,
              lbTxt: getBranchStreet(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: nationalIDAddressController,
              kbType: TextInputType.number,
              obscTxt: false,
              lbTxt: getNationalAddressTxt(),
            ),
            Container(
              width: scWidth / 1.15,
              height: scHeight / 15,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: CustomColors().primaryGreenColor,
                    width: 1.5,
                  )),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    decoration: InputDecoration.collapsed(hintText: ''),
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: CustomColors().darkGrayColor),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != dropdownValue) {
                          city = newValue!;
                          print(city);
                        } else
                          city = ' ';
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            TextFieldDesign.disableTextFieldStyle(
                context: context,
                verMarg: 5,
                horMarg: 0,
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
                    height: 1.5,
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

  //Add setState to method to update
  //status without restarting app
  void addBranch() async {
    if (nameController.value.text == '') {
      showErrorDialog(LocaleKeys.branch_name_required.tr());
      return;
    }
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

    if (districtController.value.text == '') {
      showErrorDialog(LocaleKeys.branch_dist_required.tr());
      return;
    }
    if (streetController.value.text == '') {
      showErrorDialog(LocaleKeys.branch_street_required.tr());
      return;
    }
    if (nationalIDAddressController.value.text == '') {
      showErrorDialog(LocaleKeys.buildingno_required.tr());
      return;
    }
    if (nationalIDAddressController.text.length != 4) {
      showErrorDialog(LocaleKeys.buildingno_length_error.tr());
      return;
    }
    if (city == ' ') {
      showErrorDialog(LocaleKeys.branch_city_required.tr());
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
    branchRepository
        .addNewBranch(
            companyID,
            nameController.text,
            phoneController.text,
            districtController.text,
            streetController.text,
            city,
            address,
            nationalIDAddressController.text,
            latLng.longitude,
            latLng.latitude)
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      address = '';
      alreadyUsedMap.clear();
      PickLocationPage.setValues();
      SuccessBranchResponseModel successBranchResponseModel =
          SuccessBranchResponseModel.fromJson(result.result);
      showSuccessMessage(context, successBranchResponseModel.message!);

      BranchModel branchModel = successBranchResponseModel.branchObject!;
      Provider.of<BranchProvider>(context, listen: true)
          .addBranchToList(branchModel);

      Navigator.pop(context);
      Navigator.pop(context);
      // widget.addToList(branchModel);
      //Navigator.pop(context, branchModel);
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

  String getBranchName() {
    return LocaleKeys.enter_branch_name.tr();
  }

  String getBranchDistrict() {
    return LocaleKeys.enter_branch_district.tr();
  }

  String getBranchStreet() {
    return LocaleKeys.enter_branch_street.tr();
  }

  String getPhoneTxt() {
    return LocaleKeys.enter_branch_phone.tr();
  }

  String getNationalAddressTxt() {
    return LocaleKeys.enter_branch_national_address.tr();
  }

  String getCityTxt() {
    return LocaleKeys.select_city.tr();
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
            LocaleKeys.cancel.tr(),
            LocaleKeys.continue_btn.tr(),
            actions));
  }
}
