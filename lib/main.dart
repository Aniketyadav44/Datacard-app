import 'package:datacard/app/modules/load/bindings/load_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'constants/color_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
