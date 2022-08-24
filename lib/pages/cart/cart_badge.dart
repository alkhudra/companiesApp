import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/route_helper.dart';
import '../../provider/product_provider.dart';
import '../../resources/custom_colors.dart';
import 'cart_page.dart';
import '../dashboard.dart';

class CartBadge extends StatefulWidget {
  const CartBadge({Key? key}) : super(key: key);

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: Badge(
          badgeContent: Text(
            productProvider.cartListCount.toString(),
            style: TextStyle(color: CustomColors().primaryWhiteColor),
          ),
          child: Icon(
            Icons.shopping_cart,
            color: CustomColors().primaryGreenColor,
            size: 30,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        moveToNewStackWithArgs(context, MaterialPageRoute(builder: (context) {
          return DashboardPage();
        }));
      },
    );
  }
}
