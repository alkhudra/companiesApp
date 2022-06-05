
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/provider/branch_provider.dart';
import 'package:khudrah_companies/provider/product_provider.dart';
import 'package:khudrah_companies/provider/genral_provider.dart';
import 'package:khudrah_companies/provider/notification_provider.dart';
import 'package:khudrah_companies/provider/order_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/route_constants.dart';
import 'package:provider/provider.dart';
import 'helpers/pref/shared_pref_helper.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if(message.data != null) {
    Map<String, dynamic> map = message.data;
    if (map.containsKey('order_id')) {
      print(map['order_id']);
    }
  }
  print('A bg msg just showed up : ${message.messageId}');
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  bool isUserLoggedIn = await PreferencesHelper.getIsUserLoggedIn == null ? false:await PreferencesHelper.getIsUserLoggedIn ;
   bool isUserFirstLogin = await PreferencesHelper.getIsUserFirstLogIn == null ? true:await PreferencesHelper.getIsUserFirstLogIn ;

  String language = await PreferencesHelper.getSelectedLanguage == null ? 'en':await PreferencesHelper.getSelectedLanguage ;

  await Firebase.initializeApp(
      // options:
      );
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/locale/lang',
        fallbackLocale: Locale('en'),
        child: MyApp(
          isUserLoggedIn: isUserLoggedIn,
          isUserFirstLogin: isUserFirstLogin,
          language :language
        )),
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
}



class MyApp extends StatefulWidget {
  final bool isUserFirstLogin, isUserLoggedIn;
  final String language;
  const MyApp(
      {Key? key, required this.isUserLoggedIn, required this.isUserFirstLogin,required this.language})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static int counter = 0;
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    color: CustomColors().primaryGreenColor,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }

    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published');
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Notification.title'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<BranchProvider>(
          create: (_) => BranchProvider(context),

        ),
        ChangeNotifierProvider<GeneralProvider>(
          create: (_) => GeneralProvider(context,widget.language ),

        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (_) => NotificationProvider(context),

        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(context),

        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(context),

        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          color: CustomColors().primaryGreenColor,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          routes: routMap,
          theme: ThemeData(
            fontFamily: 'Almarai',
            accentColor: CustomColors().primaryGreenColor,
            primarySwatch: Colors.green,
          ),
          home: getRout() //tempHome()
          // home: tempHome(),
          ),
    );
  }



  Widget getRout() {
    // print(isUserFirstLogin);

    if (widget.isUserFirstLogin == false && widget.isUserLoggedIn == true)
      return DashboardPage();
    if (widget.isUserFirstLogin == false && widget.isUserLoggedIn == false)
      return LogInPage();
    else
      return LanguagePage();
  }


}
