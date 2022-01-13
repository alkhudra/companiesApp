import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/network/models/branches/branch_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

import 'add_brunches_page.dart';

class BranchItem extends StatefulWidget {
  final BranchModel item;
  final int branchNumber;
  const BranchItem({Key? key, required this.item,required this.branchNumber}) : super(key: key);

  @override
  _BranchItemState createState() => _BranchItemState();
}

class _BranchItemState extends State<BranchItem> {


  @override
  Widget build(BuildContext context) {
    int branchNo = widget.branchNumber;
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.fromBorderSide(BorderSide(
        color: CustomColors().primaryGreenColor,
        width: 2,
      ))),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              LocaleKeys.branch.tr() + " $branchNo",
             // widget.item.adress.toString(),
              style: TextStyle(
                  color: CustomColors().brownColor,

                  fontSize: 15),
            ),
          )
          ,
          SizedBox(
          width: 10,
          )
          ,
          Container(

            padding: EdgeInsets.all(5),
            child: Icon(Icons.edit , color: CustomColors().primaryGreenColor,)
          ),
        ],
      ),
    );
  }
}
/*
TextButton.icon(
onPressed: () {},
icon: Icon(
Icons.edit,
color: CustomColors().primaryWhiteColor,
size: 10,
),
label: Text(
LocaleKeys.edit.tr(),
style: TextStyle(
color: CustomColors().primaryWhiteColor,
fontWeight: FontWeight.w600,
),
),
),*/
