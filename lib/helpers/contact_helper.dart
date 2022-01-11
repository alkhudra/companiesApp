import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

//--------------
void directToPhoneCall(String number) async {

  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );


  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not launch $launchUri';
  }
}

//--------------

void openMap(double lat, double lng) async {
  // Android
  var url = 'geo:$lat,$lng';
  if (Platform.isIOS) {
    // iOS
    url = 'http://maps.apple.com/?ll=$lat,$lng';
  }
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//--------------
void sendMail(String email) async {
  // Android and iOS
  var uri = 'mailto:$email';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

void openWhatsApp(String phone)async{

  String message = 'hello ';
  String uri;
  if (Platform.isAndroid) {
    // add the [https]
    uri= "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
  } else {
    // add the [https]
    uri= "https://api.whatsapp.com/send?phone=$phone";   //=${Uri.parse(message)}"; // new line
  }
//  String uri= 'https://api.whatsapp.com/send?phone=$phone';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
