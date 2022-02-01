import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({ Key? key }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return notifCard();
        },
        //replace count by array.length
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 25),
      ),
      appBar: bnbAppBar(context, LocaleKeys.notifications.tr()),
    );
  }

  Widget notifCard() {
    return ListTile(
      title: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              border: Border.all(
                color: CustomColors().primaryGreenColor,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    width: 5,
                    height: MediaQuery.of(context).size.height*0.1,
                    color: CustomColors().primaryGreenColor,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.height*0.14,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/ic_fruit_green.png')
                      )
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //replace by order no
                          child: Text('Order Num', style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        Container(
                          //replace by actual date
                          child: Text('25/01/2022', style: TextStyle(
                            color: CustomColors().primaryGreenColor,
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ),
                    Container(
                      //replace text by notification
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                      child: Text(LocaleKeys.on_the_way.tr(),
                      style: TextStyle(
                        fontSize: 16
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}