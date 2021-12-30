import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/pages/pick_location_page.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddbranchesPage extends StatefulWidget {
  const AddbranchesPage({Key? key}) : super(key: key);

  @override
  _AddbranchesPageState createState() => _AddbranchesPageState();
}

class _AddbranchesPageState extends State<AddbranchesPage> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  String dropdownValue = LocaleKeys.enter_branch_country.tr();


  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo:
      /********
       *
       * design problems:
       * height of card  , width of main column,place of btn
       * *********/
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: phoneController,
                    kbType: TextInputType.phone,
                    lbTxt: LocaleKeys.enter_branch_phone.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: addressController,
                    kbType: TextInputType.name,
                    lbTxt: LocaleKeys.enter_branch_address.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: zipCodeController,
                    kbType: TextInputType.number,
                    lbTxt: LocaleKeys.enter_branch_zip_code.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: cityController,
                    kbType: TextInputType.text,
                    lbTxt: LocaleKeys.enter_branch_city.tr(),
                  ),
                  DropdownButton<String>(
                      value: dropdownValue,
                      style: TextStyle(color: CustomColors().blackColor),
                      underline: Container(
                        color: CustomColors().primaryGreenColor,
                        height: 1,
                          margin:    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                /*        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: 12,//MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              color: CustomColors().primaryGreenColor,
                              width: 1.5),
                        ),*/
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        LocaleKeys.enter_branch_country.tr(),
                        LocaleKeys.ksa.tr()
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(LocaleKeys.add_location.tr()),
                  ),

                  Container(
                      height: ButtonsDesign.buttonsHeight,
                      margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: MaterialButton(
                        onPressed: () {


                          Navigator.push(context, MaterialPageRoute(builder: (context) {

                              return PickLocationPage();
                          }));
                        },
                        shape: StadiumBorder(),
                        child: ButtonsDesign.buttonsText(
                            LocaleKeys.add_branch.tr(),
                            CustomColors().primaryWhiteColor),
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
}
