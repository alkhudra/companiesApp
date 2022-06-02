import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/order_tile_design.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/orders/GetOrderResponseModel.dart';
import 'package:khudrah_companies/network/models/orders/order_header.dart';

import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/repository/order_repository.dart';
import 'package:khudrah_companies/provider/order_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int pageNumber = 1;
  int pageSize = listItemsCount;
  List<OrderHeader> list = [];
  bool isThereMoreItems = false;

  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getListData();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,

      body: FutureBuilder<GetOrdersResponseModel?>(
        future: getListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return pageDesign(context);
          } else
            return errorCase(snapshot);
        },
      ),
      // endDrawer: drawerDesign(context),
      appBar: bnbAppBar(context, LocaleKeys.my_orders.tr()),
    );
  }
//---------------------

 Widget pageDesign(BuildContext context) {
   return list.length > 0
        ?  Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                itemBuilder: ((context, index) {
                  return orderTileDesign(context, list[index]);
                }),
                itemCount: list.length,
              ),
              if (isThereMoreItems == true)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          )
        : noItemDesign(
            LocaleKeys.no_finished_orders.tr(), 'images/not_found.png');
  }

  //--------------------------
 Future<GetOrdersResponseModel?> getListData() async {

    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse =
        await orderRepository.getAllOrders(pageSize, pageNumber);
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      print('order list is ' + apiResponse.result.toString());

      if(apiResponse.result != []) {
        GetOrdersResponseModel responseModel =
        GetOrdersResponseModel.fromJson(apiResponse.result);

        if (pageNumber == 1)
          list = responseModel.orderList;
        else
          list.addAll(responseModel.orderList);

        if (responseModel.orderList.length > 0) {
          if (responseModel.orderList.length < listItemsCount) {
            isThereMoreItems = false;
          } else {
            isThereMoreItems = true;
            pageNumber ++;
          }
        } else {
          isThereMoreItems = false;
          pageNumber = 1;
        }
        return responseModel;
      }
      //-----------------------------------

    } else {
      throw ExceptionHelper(apiResponse.message);
    }

  }
}
