import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/search_bar.dart';
import 'package:khudrah_companies/pages/search_page_list.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class TextFieldDesign {
  static textFieldStyle(
      {context,
      double? verMarg,
      double? horMarg,
      TextEditingController? controller,
      TextInputType? kbType,
      String? lbTxt,
      validat,
      enabled,
      obscTxt}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              enabled: enabled,
              obscureText: obscTxt,
              controller: controller,
              keyboardType: kbType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validat,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: lbTxt,
                labelStyle: TextStyle(
                    color: CustomColors().blackColor.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }
//-----------------------------------------

  static disableTextFieldStyle(
      {context,
      double? verMarg,
      double? horMarg,
      TextInputType? kbType,
      String? lbTxt,
      validat,
      enabled,
      obscTxt}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        color: CustomColors().grayColor,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              enabled: enabled,
              obscureText: obscTxt,
              keyboardType: kbType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validat,
              style: TextStyle(
                  color: CustomColors().blackColor, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: lbTxt,
                labelStyle: TextStyle(
                    color: CustomColors().blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }
//-----------------------------------------

  static editTextFieldStyle(
      {context,
      double? verMarg,
      double? horMarg,
      TextEditingController? controller,
      TextInputType? kbType,
      /*String? initValue,*/ validat}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Expanded(
            child: TextFormField(
              //  initialValue: initValue,
              controller: controller,
              keyboardType: kbType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validat,
              style: TextStyle(
                  color: CustomColors().blackColor, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                //     hintText: initValue,
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }
//-----------------------------------------

  static emptyLargeFieldStyle(
      {context,
      double? verMarg,
      double? horMarg,
      TextEditingController? controller,
      TextInputType? kbType,
      String? initValue,
      validat}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Expanded(
            child: TextFormField(
              maxLines: 4,
              //  initialValue: initValue,
              controller: controller,
              keyboardType: kbType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validat,
              style: TextStyle(color: CustomColors().blackColor, fontSize: 15),
              decoration: InputDecoration(
                labelText: initValue,
                labelStyle: TextStyle(
                    color: CustomColors().blackColor.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }
  //-----------------------------------------

  static searchFieldStyle(
      {context,
        bool? fromSearchPage,
      double? verMarg,
      double? horMarg,
      TextEditingController? controller,
      String? initValue}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                if(controller!.text != '')
                SearchHelper.directToSearchPage(context,controller,fromSearchPage: fromSearchPage);
              },
              controller: controller,

              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: initValue,
                labelStyle: TextStyle(
                    color: CustomColors().blackColor.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }
  //-----------------------------------------


    static phoneTextFieldStyle(
      {context,
      double? verMarg,
      double? horMarg,
      TextEditingController? controller,
      TextInputType? kbType,
      String? lbTxt,
      validat,
      enabled,
      obscTxt}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width / 1.15,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: CustomColors().primaryGreenColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              maxLength: 10,
              enabled: enabled,
              obscureText: obscTxt,
              controller: controller,
              keyboardType: kbType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validat,
              style: TextStyle(
                  color: CustomColors().blackColor,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: lbTxt,
                labelStyle: TextStyle(
                    color: CustomColors().blackColor.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                focusColor: CustomColors().blackColor,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }

    //-----------------------------------------

}

InputDecoration textFieldDecorationWithIcon(String hint, IconData icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: CustomColors().primaryGreenColor,
    hintText: hint,
    hintStyle: TextStyle(color: CustomColors().grayColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: CustomColors().primaryGreenColor, width: 1.0),
    ),
    prefixIcon: Icon(
      icon,
      color: CustomColors().grayColor,
    ),
  );
}

//-----------------------------------------

InputDecoration textFieldDecoration(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: CustomColors().primaryGreenColor,
    hintText: hint,
    hintStyle: TextStyle(color: CustomColors().grayColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: CustomColors().primaryGreenColor, width: 1.0),
    ),
  );
}
