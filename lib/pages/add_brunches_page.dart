import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/brand_name.dart';
import 'package:khudrah_companies/designs/card_design.dart';
import 'package:khudrah_companies/designs/text_field_design.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AddBrunchesPage extends StatefulWidget {
  const AddBrunchesPage({Key? key}) : super(key: key);

  @override
  _AddBrunchesPageState createState() => _AddBrunchesPageState();
}

class _AddBrunchesPageState extends State<AddBrunchesPage> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  String dropdownValue = LocaleKeys.enter_brunch_country.tr();
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
                    lbTxt: LocaleKeys.enter_brunch_phone.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: addressController,
                    kbType: TextInputType.name,
                    lbTxt: LocaleKeys.enter_brunch_address.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: zipCodeController,
                    kbType: TextInputType.number,
                    lbTxt: LocaleKeys.enter_brunch_zip_code.tr(),
                  ),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: cityController,
                    kbType: TextInputType.text,
                    lbTxt: LocaleKeys.enter_brunch_city.tr(),
                  ),

                  DropdownButton<String>(
                      value: dropdownValue,
                      style: TextStyle(color: CustomColors().blackColor),
                      underline: Container(
                        margin: EdgeInsets.symmetric(horizontal:0, vertical: 15),

                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              color: CustomColors().primaryGreenColor,
                              width: 1.5),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp),


                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[LocaleKeys.enter_brunch_country.tr(),LocaleKeys.ksa.tr()]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),

                  Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          shape: StadiumBorder(),
                          child: ButtonsDesign.buttonsText(
                              LocaleKeys.add_location.tr(),
                              CustomColors().primaryWhiteColor),
                          color: CustomColors().primaryGreenColor,
                        ),
                        Icon(Icons.my_location,
                            color: CustomColors().primaryWhiteColor),
                      ],
                    ),
                  ),
                  Container(
                      height: ButtonsDesign.buttonsHeight,
                      margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: MaterialButton(
                        onPressed: () {},
                        shape: StadiumBorder(),
                        child: ButtonsDesign.buttonsText(
                            LocaleKeys.add_brunch.tr(),
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
