import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

//--------------
void directToPhoneCall(String number) async {
  if (await canLaunch('tel:+$number')) {
    await launch('tel:+$number');
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

  String uri= 'https://api.whatsapp.com/send?phone=$phone';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
