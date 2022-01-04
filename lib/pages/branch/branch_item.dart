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
  const BranchItem({Key? key, required this.item}) : super(key: key);

  @override
  _BranchItemState createState() => _BranchItemState();
}

class _BranchItemState extends State<BranchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(
        color: CustomColors().primaryGreenColor,
        width: 2,
      ))),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(widget.item.branchName.toString()),
          greenBtn(LocaleKeys.edit.tr(),
              EdgeInsets.only(left: 50, right: 50, bottom: 20), () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddBranchesPage();
                }));

              })
        ],
      ),
    );
  }
}
