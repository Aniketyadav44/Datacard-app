import 'package:get/get.dart';

import 'package:datacard/app/modules/document/bindings/document_binding.dart';
import 'package:datacard/app/modules/document/views/document_view.dart';
import 'package:datacard/app/modules/home/bindings/home_binding.dart';
import 'package:datacard/app/modules/home/views/home_view.dart';
import 'package:datacard/app/modules/load/bindings/load_binding.dart';
import 'package:datacard/app/modules/load/views/load_view.dart';
import 'package:datacard/app/modules/lock/bindings/lock_binding.dart';
import 'package:datacard/app/modules/lock/views/lock_view.dart';
import 'package:datacard/app/modules/login/bindings/login_binding.dart';
import 'package:datacard/app/modules/login/views/login_view.dart';
import 'package:datacard/app/modules/update/bindings/update_binding.dart';
import 'package:datacard/app/modules/update/views/update_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOAD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOAD,
      page: () => LoadView(),
      binding: LoadBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE,
      page: () => UpdateView(),
      binding: UpdateBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT,
      page: () => DocumentView(),
      binding: DocumentBinding(),
    ),
    GetPage(
      name: _Paths.LOCK,
      page: () => LockView(),
      binding: LockBinding(),
    ),
  ];
}
