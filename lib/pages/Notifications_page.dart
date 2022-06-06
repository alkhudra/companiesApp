import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/designs/drawar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khudrah_companies/designs/no_item_design.dart';
import 'package:khudrah_companies/designs/order_tile_design.dart';
import 'package:khudrah_companies/helpers/pref/shared_pref_helper.dart';
import 'package:khudrah_companies/network/API/api_response.dart';
import 'package:khudrah_companies/network/API/api_response_type.dart';
import 'package:khudrah_companies/network/helper/exception_helper.dart';
import 'package:khudrah_companies/network/helper/network_helper.dart';
import 'package:khudrah_companies/network/models/notification/get_notification_response_model.dart';
import 'package:khudrah_companies/network/models/notification/notification_model.dart';
import 'package:khudrah_companies/network/models/user_model.dart';
import 'package:khudrah_companies/network/repository/notification_repository.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/provider/notification_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _isLoadedPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotificationProvider>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: getListData(value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return pageDesign(context, snapshot.data!);
              } else
                return errorCase(snapshot);
            },
          );
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.notifications.tr()),
    );
  }

  Widget notifCard(NotificationModel model) {
    return ListTile(
      title: Center(
        child: GestureDetector(
          onTap: () {
            if (model.orderId != null && model.orderId != 0) {
              print(model.orderId);
              directToOrderDetails(context, orderId: model.orderId);
            }
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
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
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: CustomColors().primaryGreenColor,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.14,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('images/ic_fruit_green.png'))),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.12),
                              //replace by order no
                              child: Text(
                                model.title!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: CustomColors().primaryGreenColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.12),
                          //replace by actual date
                          child: Text(
                            model.sentDateTime!.toString(),
                            style: TextStyle(
                              color: CustomColors().primaryGreenColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          //replace text by notification
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.12),
                          child: Text(
                            model.body!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: CustomColors().darkBlueColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getListData(NotificationProvider value) async {
    // if(_isLoadedPage == false) {
    if (value.getNotificationList.isEmpty) {
      Map<String, dynamic> headerMap = await getHeaderMap();

      NotificationRepository orderRepository =
          NotificationRepository(headerMap);

      ApiResponse apiResponse = await orderRepository.getAllNotifications();

      if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
        GetNotificationResponseModel? responseModel =
            GetNotificationResponseModel.fromJson(apiResponse.result);

        _isLoadedPage = true;
        print(responseModel.notificationList.toString());
        value.setNotificationList(responseModel.notificationList);
        //-----------------------------------
        return responseModel.notificationList;
      } else {
        throw ExceptionHelper(apiResponse.message);
      }
    } else
      return value.notificationList;
    //  }
  }

  Widget pageDesign(BuildContext context, list) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return provider.listCount > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return notifCard(provider.notificationList![index]);
                },
                itemCount: provider.listCount,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(bottom: 25),
              )
            : noItemDesign(
                LocaleKeys.no_notification.tr(), 'images/not_found.png');
      },
    );
  }
}
