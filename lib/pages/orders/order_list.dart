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
import 'package:khudrah_companies/network/models/orders/get_orders_response_model.dart';

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
 // int pageNumber = 1;
  int pageSize = listItemsCount;
  // List<OrderHeader> list = [];
  bool isThereMoreItems = false;
  static String name = '', email = '';

  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getListData();
    }
  }

  @override
  void initState() {
    super.initState();
    setValues();
    _controller.addListener(_scrollListener);
  }

  void setValues() async {
    User user = await PreferencesHelper.getUser;
    name = user.companyName!;
    email = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,

      body: FutureBuilder(
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
      endDrawer: drawerDesignWithName(context, name, email),
    );
  }
//---------------------

  pageDesign(BuildContext context) {
/*    List<OrderHeader> currentOrder = [], finishedOrder = [];
    for (OrderHeader orderItems in model.orderList) {
      if (orderItems.orderStatus == delivered) {
        finishedOrder.add(orderItems);
      } else {
        currentOrder.add(orderItems);
      }
    }*/


    return Consumer<OrderProvider>(
      builder: (context, value, child) {
        return value.listCount > 0
            ? ListView.builder(
                controller: _controller,
                itemBuilder: ((context, index) {
                  if(value.getLoadMoreDataStatus == true) {
                    if (index == value.orderList.length-1) {
                      return Center(
                        child: CircularProgressIndicator(), //value.getLoadMoreDataStatus == true ? CircularProgressIndicator():null,
                      );
                    }
                  }
                  return orderTileDesign(
                      context, value.getorderList[index]);
                }),
                itemCount: value.listCount,
              )
            : noItemDesign(
                LocaleKeys.no_finished_orders.tr(), 'images/not_found.png');
      },
    );
  }

  //--------------------------
  getListData() async {
    final provider = Provider.of<OrderProvider>(context, listen: false);

    if (provider.orderList.isEmpty || provider.getLoadMoreDataStatus == true) {
      Map<String, dynamic> headerMap = await getHeaderMap();

      OrderRepository orderRepository = OrderRepository(headerMap);

      ApiResponse apiResponse =
          await orderRepository.getAllOrders(pageSize, provider.pageNumber);

      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        GetOrdersResponseModel? responseModel =
            GetOrdersResponseModel.fromJson(apiResponse.result);

        print(responseModel.orderList.length);

        provider.addMoreItemsToList(responseModel.orderList);

        if (responseModel.orderList.length > 0) {
          if (responseModel.orderList.length < listItemsCount)
            provider.saveLoadMoreDataStatus(false);
          else
            provider.saveLoadMoreDataStatus(true);
        } else {
          provider.saveLoadMoreDataStatus(false);
       //   provider.resetPageNumber();
        }

        //  orderList = responseModel.orderList;
        /*  if (pageNumber == 1)
          orderList = responseModel.orderList;
        else
          orderList.addAll(responseModel.orderList);

        if (responseModel.orderList.length > 0) {
          if (responseModel.orderList.length < listItemsCount) {
            isThereMoreItems = false;
          } else {
            isThereMoreItems = true;
          }
        } else {
          isThereMoreItems = false;
          pageNumber = 1;
        }*/
        //-----------------------------------
        return responseModel.orderList;
      } else {
        throw ExceptionHelper(apiResponse.message);
      }
    } else

    return provider.orderList;
  }
}
