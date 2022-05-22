import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/network/models/product/product_model.dart';
import 'package:khudrah_companies/pages/products/product_tile.dart';
import 'package:khudrah_companies/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {

  List<ProductsModel>? productsList =[];


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(

      builder: (context, value, child) {
       // value.setList(productsList);
        return ListView.builder(
          itemBuilder: (context, index) {
            final ProductsModel model = productsList![index];
            return ProductTile(

              productModel: model,
              addToCart: () {
                value.addToCart(model.productId);
              },
              addQtyToCart: () {
                value.increaseQty(model.userProductQuantity!, model.productId);
              },
              deleteFromCart: () {
                value.deleteFromCart(model.productId);
              },
              reduceQtyFromCart: () {
                value.decreaseQty(model.userProductQuantity!, model.productId);
              },
              favPressed: () {
                value.addToFav(model.isFavourite!, model.productId);
              },
            );
          },
          itemCount: productsList!.length,
        );
      },
    );
  }

  ProductList(this.productsList);
}
