import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({ Key? key }) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  double price = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: GridView.builder(
        itemBuilder: (context, index) {
          return favoritesCard();
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 13/14
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 8,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      ),
      appBar: bnbAppBar(context, LocaleKeys.favorites.tr()),
    );
  }

  Widget favoritesCard() {
    return GridTile(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: CustomColors().primaryWhiteColor,
          image: DecorationImage(
            image: AssetImage('images/green_fruit.png'),
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: CustomColors().darkGrayColor.withOpacity(0.4),
              offset: Offset(2.0, 3.0),
              blurRadius: 3.0,
              spreadRadius: .0
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Delete icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {}, 
                    icon: Icon(FontAwesomeIcons.trash,
                    color: CustomColors().redColor,
                    size: 22,)
                  ),
                ),
              ],
            ),
            //name and other details
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //name
                Container(
                  alignment: Alignment.center,
                  child: Text('Avocado', 
                  style: TextStyle(
                    color: CustomColors().brownColor,
                    fontSize: 18.5,
                  ),),
                ),
                // SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //price
                    Container(
                      child: Text('$price ' + LocaleKeys.sar_per_kg.tr(),
                      style: TextStyle(
                        color: CustomColors().primaryGreenColor,
                        fontSize: 14
                      ),),
                    ),
                    //cart icon
                    Container(
                      child: Icon(FontAwesomeIcons.cartPlus,
                      color: CustomColors().primaryGreenColor,
                      size: 18,
                    ),
                    ),
                  ],
                ),
                SizedBox(height: 9,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
