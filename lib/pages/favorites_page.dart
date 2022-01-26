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
  int counter = 0;

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
          childAspectRatio: 14/17.4
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

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors().primaryWhiteColor,
          // image: DecorationImage(
          //   image: AssetImage('images/green_fruit.png'),
          // ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: CustomColors().darkGrayColor.withOpacity(0.4),
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              spreadRadius: .8
            )
          ]
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //Delete icon
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: IconButton(
                    onPressed: () {}, 
                    icon: Icon(FontAwesomeIcons.trash,
                    color: CustomColors().redColor,
                    size: 20,),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ],
            ),
            //name and other details
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset('images/green_fruit.png'),
                ),
                //name
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: Text('Avocado', 
                  style: TextStyle(
                    color: CustomColors().brownColor,
                    fontSize: 18.5,
                  ),),
                ),
                Container(
                  width: scWidth*0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //price
                      Container(
                        child: Text('$price  ' + LocaleKeys.sar_per_kg.tr(),
                        style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: scHeight*0.01,),
                //Counter and cart icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Counter
                    Container(
                      width: 80,
                      height: 26,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: CustomColors().grayColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // counter >= 0 ? counter -= counter : counter;
                            },
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
                            onTap: () {
                              // counter >= 0 ? counter += counter : counter;
                            },
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
                    ),
                    //Cart icon
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.cartPlus,
                          color: CustomColors().primaryGreenColor,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
