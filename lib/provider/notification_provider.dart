import 'dart:collection';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:khudrah_companies/network/models/notification/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel>? notificationList = [];

  BuildContext context;

  NotificationProvider(this.context);


  setNotificationList(List<NotificationModel>? list){
    notificationList = list;
    notifyListeners();
  }

  addNotificationToList(NotificationModel model) {
    notificationList!.insert(0,model);
    notifyListeners();
  }

  removeNotificationFromList(NotificationModel model) {
    final branchId = model.id;
    NotificationModel? notificationModel =
    notificationList!.firstWhereOrNull((element) {
      return element.id == branchId;
    });
    if (notificationModel != null) {
      notificationList!.remove(notificationModel);
      notifyListeners();
    }
  }

  int get listCount {
    return notificationList!.length;
  }

  UnmodifiableListView<NotificationModel> get getNotificationList {
    //  if(branchList!.length !=0)
    return UnmodifiableListView(notificationList!);
    // else return loadData();

  }

}
