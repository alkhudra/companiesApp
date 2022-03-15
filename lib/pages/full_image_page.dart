import 'package:flutter/material.dart';
import 'package:khudrah_companies/Constant/api_const.dart';

class FullImagePage extends StatefulWidget {
  final String imageUrl;
  const FullImagePage({Key? key,required this.imageUrl}) : super(key: key);

  @override
  _FullImagePageState createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: FittedBox(
            child: Image.network(ApiConst.dashboard_url + widget.imageUrl,
              fit: BoxFit.cover,

              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('images/grapevector.png');
              },),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: const Text('Transaction Detail'),
      ),
    );
  }
}
