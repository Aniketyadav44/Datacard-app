import 'package:datacard/app/data/providers/fcm_provider.dart';
import 'package:datacard/app/data/services/firebase_service.dart';
import 'package:datacard/app/modules/load/bindings/load_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';
import 'constants/color_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.initializeFirebase();
  final RemoteMessage? _message =
      await FirebaseService.firebaseMessaging.getInitialMessage();
  await Hive.initFlutter();
  await Hive.openBox('local');
  runApp(MyApp(
    message: _message,
  ));
}

class MyApp extends StatefulWidget {
  RemoteMessage? message;
  MyApp({super.key, this.message});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    //for if the notification is clicked when the app is terminated
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FCMProvider.setContext(context);
      if (this.widget.message != null) {
        RemoteMessage firstMessage = this.widget.message!;
        Future.delayed(const Duration(milliseconds: 1000), () async {
          RemoteNotification notification = firstMessage.notification!;
          AndroidNotification? android = firstMessage.notification?.android;
          if (android != null) {
            var uidDataString = firstMessage.data["uidData"];
            var uidDataList = uidDataString.split('.');
            // 0 -> data type, 1 -> file uid, 2 -> requester uid
            Get.offAllNamed(Routes.LOCK, arguments: [
              firstMessage.data["screen"],
              uidDataList[0],
              uidDataList[1],
              uidDataList[2],
            ]);
          }
        });
      }
    });

    Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
    _stream.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        var uidDataString = message.data["uidData"];
        var uidDataList = uidDataString.split('.');
        // 0 -> data type, 1 -> file uid, 2 -> requester uid
        Get.toNamed(message.data["screen"],
            arguments: [uidDataList[0], uidDataList[1], uidDataList[2]]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: ColorConstants.secondaryColor,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding: LoadBinding(),
      getPages: AppPages.routes,
    );
  }
}
