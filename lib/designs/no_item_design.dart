import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:lottie/lottie.dart';

Widget noItemDesign(String txt, String imageUrl) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset(
              'images/tree_anim.json',
              width: 230,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15,),
          // Text('Oops!', style: TextStyle(
          //   color: CustomColors().darkBlueColor,
          //   fontSize: 16,
          //   fontWeight: FontWeight.w700
          // ),),
          SizedBox(height: 5,),
          errorText(txt),
          // Image(image: AssetImage('images/green_fruit.png')),
          // Text('${snapshot.error}' ,),
        ],
      ));
}

Widget errorText(String txt){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(txt, style: TextStyle(
      color: CustomColors().primaryGreenColor,
      fontSize: 15,
    ),),
  );

}
