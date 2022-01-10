import 'package:flutter/material.dart';
import 'package:khudrah_companies/pages/favorites_page.dart';
import 'package:khudrah_companies/pages/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(isHasBranch: false),
    FavoritesPage(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}