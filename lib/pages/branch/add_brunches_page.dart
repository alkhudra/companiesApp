import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/app_bar_txt.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/helpers/location_helper.dart';
import 'package:khudrah_companies/pages/pick_location_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AddBranchesPage extends StatefulWidget {
  // final Map<String ,dynamic>  map ;
  const AddBranchesPage({Key? key}) : super(key: key);

  @override
  _AddBranchesPageState createState() => _AddBranchesPageState();
}

class _AddBranchesPageState extends State<AddBranchesPage> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  static LatLng latLng = LatLng(0, 0);
  static String address = LocaleKeys.enter_branch_country.tr();

// = LatLng(ksaLat,ksaLng);
  Map<String, dynamic> alreadyUsedMap = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarText(LocaleKeys.add_branch.tr(), true),
      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "please add youccccccccccccccr branches ",
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
              lbTxt: LocaleKeys.enter_branch_phone.tr(),
            ),
            TextFieldDesign.textFieldStyle(
              context: context,
              verMarg: 5,
              horMarg: 0,
              controller: zipCodeController,
              kbType: TextInputType.number,
              obscTxt: false,
              lbTxt: LocaleKeys.enter_branch_zip_code.tr(),
            ),
            TextFieldDesign.textFieldStyle(
                context: context,
                verMarg: 5,
                horMarg: 0,
                controller: cityController,
                kbType: TextInputType.text,
                obscTxt: false,
                lbTxt: LocaleKeys.ksa.tr(),
                enabled: false),
            Container(
                height: ButtonsDesign.buttonsHeight,
                margin: EdgeInsets.all(20),
                child: MaterialButton(
                  onPressed: () {
                    addLocation();
                  },
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText(LocaleKeys.add_location.tr(),
                      CustomColors().primaryWhiteColor),
                  color: CustomColors().primaryGreenColor,
                )),
            TextFieldDesign.textFieldStyle(
                context: context,
                verMarg: 5,
                horMarg: 0,
                controller: addressController,
                kbType: TextInputType.streetAddress,
                obscTxt: false,
                lbTxt: address,
                enabled: false),
            Container(
                height: ButtonsDesign.buttonsHeight,
                margin: EdgeInsets.all(20),
                child: MaterialButton(
                  onPressed: () {
                    //todo: add to db and go to list
                  },
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText(LocaleKeys.add_branch.tr(),
                      CustomColors().primaryWhiteColor),
                  color: CustomColors().primaryGreenColor,
                )),
          ],
        ),
      ),
    );
  }

  //---------------------------------

  void addLocation() async {
    // ask for permission
    LatLng userLocation;
    if (alreadyUsedMap.isEmpty) {
      getUserLatLng().then((value) {
        userLocation = value;
        directToPickLocationPage(userLocation);
      });
    } else {
      userLocation = alreadyUsedMap[branchLatLng];
      directToPickLocationPage(userLocation);
    }
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
      });

      print(address);
    }
  }

}
