import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khudrah_companies/pages/auth/login_page.dart';
import 'package:khudrah_companies/pages/branch/add_brunches_page.dart';
import 'package:khudrah_companies/pages/dashboard.dart';
import 'package:khudrah_companies/pages/home_page.dart';
import 'package:khudrah_companies/pages/language/language_page.dart';
import 'package:khudrah_companies/provider/product_list_provider.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';
import 'package:khudrah_companies/router/custom_route.dart';
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
  print('A bg msg just showed up : ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        child: MyApp()),
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
}

// Future init() async  1q2a{
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// await flutterLocalNotificationsPlugin
// .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// ?.createNotificationChannel(channel);

// await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//   alert: true,
//   badge: true,
//   sound: true
// );
// }

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static bool isUserFirstLogin = false;
  static bool isUserLoggedIn = false;
  static int counter = 0;
  @override
  void initState() {
    super.initState();
    setValues();
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
                    //TODO: Add custom icon
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

  void showNotification() async {
    setState(() {
      counter++;
    });

    String? token = await FirebaseMessaging.instance.getToken();

    print('token:' + token!);

    flutterLocalNotificationsPlugin.show(
        0,
        'Testing $counter',
        'How you doin?',
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: CustomColors().primaryGreenColor,
                playSound: true,
                //TODO: Add custom icon
                icon: '@mipmap/ic_launcher'),
                // iOS: IOSNotificationDetails()
          )
      );

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );


      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductListProvider>(
          create: (_) => ProductListProvider(),
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
          home: tempHome()
          // home: tempHome(),
          ),
    );
  }

  //replace getRout widget with tempHome to test local notifs
  Widget tempHome() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Notifications'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: Text('Send local Notif'),
              onPressed: showNotification,
            ),
          ),
        ],
      ),
    );
  }

  Widget getRout() {
    print(isUserFirstLogin);

    if (isUserFirstLogin == false && isUserLoggedIn == true)
      return DashboardPage();
    if (isUserFirstLogin == false && isUserLoggedIn == false)
      return LogInPage();
    else
      return LanguagePage();
  }

  setValues() async {
    isUserFirstLogin = await PreferencesHelper.getIsUserFirstLogIn;
    isUserLoggedIn = await PreferencesHelper.getIsUserLoggedIn;
  }
}
