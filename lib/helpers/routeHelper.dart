import 'package:flutter/cupertino.dart';
import 'package:khudrah_companies/router/route_constants.dart';

void moveToNewStack(BuildContext context , String routeString){
  Navigator.of(context).pushNamedAndRemoveUntil(routeString, (Route<dynamic> route) => false);

}