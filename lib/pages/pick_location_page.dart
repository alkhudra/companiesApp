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
import 'package:khudrah_companies/dialogs/progress_dialog.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickLocationPage();
}

class _PickLocationPage extends State<PickLocationPage> {
  var geoLocator = Geolocator();
  static String selectedAddress = '';
  late Completer<GoogleMapController> mapController = Completer();
  List<Marker> marker = [];
  static LatLng? latLng ;

  bool isGetLocation= false;
  //-------------------------------

  @override
  void initState() {
    //----------show progress----------------

  //  showLoaderDialog(context);
    getLatLng();
    super.initState();
  }

  //-------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarText(LocaleKeys.add_location.tr(), true),
      body: Container(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child:
        //    if(isGetLocation)
            GoogleMap(
              onTap: showMarker,
              markers: Set.from(marker),
              onCameraMove: _onCameraMove,
              onMapCreated: _onMapCreated,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(target: latLng!, zoom: 11.5),
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
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.all(20),
                    child: MaterialButton(
                      onPressed: () {
                        Map<String, dynamic> map = {
                          branchLatLng: latLng,
                          branchAddress: selectedAddress
                        };
                        Navigator.pop(context, map);
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(
                          LocaleKeys.confirm_location.tr(),
                          CustomColors().primaryWhiteColor),
                      color: CustomColors().primaryGreenColor,
                    )),
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
      latLng = pp;
      selectedAddress = '$name , $street , $city , $country , $postalCode';
      print(selectedAddress);
    });
  }

  //-------------------------------

  void getLatLng() {
    // showLoaderDialog(context);
    Position pp;
    determinePosition().then((value) {
      pp = value;
      latLng = LatLng(pp.latitude, pp.longitude);
      //--- show marker if already selected
      if (latLng!.longitude != 0) showMarker(latLng!);

    });
  }

  //-------------------------------

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //-------------------------------

  void showMarker(LatLng selectedPoint) {
    marker = [];
    CameraPosition(target: selectedPoint);
    marker.add(Marker(

     // onDragEnd: onf,
        markerId: MarkerId(selectedPoint.toString()), position: selectedPoint));
    convertToAddress(selectedPoint);


   // cameraPosition.target = selectedPoint;
/*    setState(() {
      _onCameraMove(cameraPosition);
    });*/

  }

  //-------------------------------

  void _onCameraMove(CameraPosition position) {
    setState(() {
      latLng = position.target;
    });
  }

  //-------------------------------

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }


}
