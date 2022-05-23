import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/snack_message.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/message_response_model.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/network/repository/cart_repository.dart';
import 'package:khudrah_companies/network/repository/product_repository.dart';
import 'package:khudrah_companies/pages/products/product_tile.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  List<ProductsModel>? productsList;

  bool enablePaging;
  dynamic controller = ScrollController();
  ProductList(this.productsList, { this.enablePaging = false,this.controller }) ;

  @override
  Widget build(BuildContext context) {
   final productProvider =  Provider.of<ProductProvider>(context, listen: true);


       // .setBranchList(home.user!.branches!);
    return  ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          controller: enablePaging == true ? controller: null,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if(enablePaging) {
              if (productProvider.getLoadMoreDataStatus == true) {
                if (index == productProvider.productListCount - 1) {
                  return Center(child: CircularProgressIndicator());
                }
              }
            }
            final ProductsModel model = productsList![index];
            return ProductTile(
              productModel: model);
          },
          itemCount: productsList!.length,
        );
     // },
   // );
  }



}
