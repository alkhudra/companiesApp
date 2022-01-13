import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khudrah_companies/Constant/conts.dart';
import 'package:khudrah_companies/Constant/locale_keys.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/designs/app_bar_txt.dart';
import 'package:khudrah_companies/designs/appbar_design.dart';
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/helpers/custom_btn.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class PickLocationPage extends StatefulWidget {
  final LatLng userLatLng;
  const PickLocationPage({Key? key, required this.userLatLng})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickLocationPage();
}

class _PickLocationPage extends State<PickLocationPage> {
  var geoLocator = Geolocator();
  static String selectedAddress = '';
  late Completer<GoogleMapController> mapController = Completer();
  List<Marker> marker = [];
  static LatLng confirmedLatLng = LatLng(0, 0);
  //static LatLng userLatLng = LatLng(ksaLat,ksaLng);

  static LatLng? temLatLng;
  bool isGetLocation = false;

  //-------------------------------

  LatLng initialCameraTarget() {
    return widget.userLatLng;
/*    if (selectedAddress == '') {
      return userLatLng;
    } else {
      return confirmedLatLng;
    }*/
  }

  @override
  void initState() {
    super.initState();

    print(initialCameraTarget());
    //----------show progress----------------
    if (confirmedLatLng.longitude == 0)
      selectedAddress = '';
    else
      showMarker(confirmedLatLng);
  }

  //-------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.add_location.tr()),
      body: Container(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: GoogleMap(
              onTap: showMarker,
              markers: Set.from(marker),
              //   onCameraMove: _onCameraMove,
              onMapCreated: _onMapCreated,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: initialCameraTarget(), zoom: 11.5),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4.9,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                color: CustomColors().cardBackgroundColor1),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(LocaleKeys.pick_location_note.tr().toUpperCase()),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    selectedAddress,
                    style: TextStyle(
                      color: CustomColors().darkBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                greenBtn(LocaleKeys.confirm_location.tr(), EdgeInsets.all(20),
                    () {
                  confirmedLatLng = temLatLng!;
                  Map<String, dynamic> map = {
                    branchLatLng: confirmedLatLng,
                    branchAddress: selectedAddress
                  };
                  Navigator.pop(context, map);
                  confirmedLatLng = LatLng(0, 0);
                  temLatLng = LatLng(0, 0);
                  selectedAddress = '';
                }),
              ],
            ),
          ),
        ],
      )),
    );
  }

  //-------------------------------

  void convertToAddress(LatLng pp) async {
    List ll = await placemarkFromCoordinates(pp.latitude, pp.longitude);
    Placemark placeMark = ll[0];
    String name, street, country, city, postalCode;
    name = placeMark.name!;
    street = placeMark.street!;
    country = placeMark.country!;
    city = placeMark.locality!;
    postalCode = placeMark.postalCode!;
    setState(() {
      temLatLng = pp;
      selectedAddress = '$name , $street , $city , $country , $postalCode';
      print(selectedAddress);
    });
  }

  //-------------------------------

  void showMarker(LatLng selectedPoint) {
    marker = [];
    marker.add(Marker(
        markerId: MarkerId(selectedPoint.toString()), position: selectedPoint));
    convertToAddress(selectedPoint);
    temLatLng = selectedPoint;
  }

  //-------------------------------

  void _onCameraMove(CameraPosition position) {
    setState(() {
      confirmedLatLng = position.target;
    });
  }

  //-------------------------------

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }
}
