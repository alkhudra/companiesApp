import 'dart:core';

import 'package:flutter/material.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class QtyContainer extends StatelessWidget {
  final int counter;
  final Function() onDeleteBtnClicked;
  final Function() onIncreaseBtnClicked, onDecreaseBtnClicked;

  QtyContainer(this.counter, this.onIncreaseBtnClicked, this.onDeleteBtnClicked,
      this.onDecreaseBtnClicked);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: scWidth * 0.25,
      height: scHeight * 0.04,
      decoration: BoxDecoration(
        color: CustomColors().grayColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          counter == 1
              ? GestureDetector(
                  onTap: onDeleteBtnClicked,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: CustomColors().primaryGreenColor,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: onDecreaseBtnClicked,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '-',
                      style: TextStyle(
                        color: CustomColors().darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              '$counter',
              style: TextStyle(
                color: CustomColors().blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: onIncreaseBtnClicked,
            child: Container(
              padding: EdgeInsets.all(4),
              child: Text(
                '+',
                style: TextStyle(
                  color: CustomColors().darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
