import 'package:get/get.dart';

import 'package:datacard/app/modules/datacard/bindings/datacard_binding.dart';
import 'package:datacard/app/modules/datacard/views/datacard_view.dart';
import 'package:datacard/app/modules/document/bindings/document_binding.dart';
import 'package:datacard/app/modules/document/views/document_view.dart';
import 'package:datacard/app/modules/faq/bindings/faq_binding.dart';
import 'package:datacard/app/modules/faq/views/faq_view.dart';
import 'package:datacard/app/modules/file/bindings/file_binding.dart';
import 'package:datacard/app/modules/file/views/file_view.dart';
import 'package:datacard/app/modules/get_access/bindings/get_access_binding.dart';
import 'package:datacard/app/modules/get_access/views/get_access_view.dart';
import 'package:datacard/app/modules/home/bindings/home_binding.dart';
import 'package:datacard/app/modules/home/views/home_view.dart';
import 'package:datacard/app/modules/load/bindings/load_binding.dart';
import 'package:datacard/app/modules/load/views/load_view.dart';
import 'package:datacard/app/modules/lock/bindings/lock_binding.dart';
import 'package:datacard/app/modules/lock/views/lock_view.dart';
import 'package:datacard/app/modules/login/bindings/login_binding.dart';
import 'package:datacard/app/modules/login/views/login_view.dart';
import 'package:datacard/app/modules/receive/bindings/receive_binding.dart';
import 'package:datacard/app/modules/receive/views/receive_view.dart';
import 'package:datacard/app/modules/received_datacard/bindings/received_datacard_binding.dart';
import 'package:datacard/app/modules/received_datacard/views/received_datacard_view.dart';
import 'package:datacard/app/modules/received_document/bindings/received_document_binding.dart';
import 'package:datacard/app/modules/received_document/views/received_document_view.dart';
import 'package:datacard/app/modules/received_history/bindings/received_history_binding.dart';
import 'package:datacard/app/modules/received_history/views/received_history_view.dart';
import 'package:datacard/app/modules/share/bindings/share_binding.dart';
import 'package:datacard/app/modules/share/views/share_view.dart';
import 'package:datacard/app/modules/shared_history/bindings/shared_history_binding.dart';
import 'package:datacard/app/modules/shared_history/views/shared_history_view.dart';
import 'package:datacard/app/modules/terms/bindings/terms_binding.dart';
import 'package:datacard/app/modules/terms/views/terms_view.dart';
import 'package:datacard/app/modules/timout/bindings/timout_binding.dart';
import 'package:datacard/app/modules/timout/views/timout_view.dart';
import 'package:datacard/app/modules/update/bindings/update_binding.dart';
import 'package:datacard/app/modules/update/views/update_view.dart';
import 'package:datacard/app/modules/verification/bindings/verification_binding.dart';
import 'package:datacard/app/modules/verification/views/verification_view.dart';

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
    GetPage(
      name: _Paths.FILE,
      page: () => FileView(),
      binding: FileBinding(),
    ),
    GetPage(
      name: _Paths.DATACARD,
      page: () => DatacardView(),
      binding: DatacardBinding(),
    ),
    GetPage(
      name: _Paths.SHARE,
      page: () => ShareView(),
      binding: ShareBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE,
      page: () => ReceiveView(),
      binding: ReceiveBinding(),
    ),
    GetPage(
      name: _Paths.GET_ACCESS,
      page: () => GetAccessView(),
      binding: GetAccessBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVED_DATACARD,
      page: () => ReceivedDatacardView(),
      binding: ReceivedDatacardBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVED_DOCUMENT,
      page: () => ReceivedDocumentView(),
      binding: ReceivedDocumentBinding(),
    ),
    GetPage(
      name: _Paths.TIMOUT,
      page: () => TimoutView(),
      binding: TimoutBinding(),
    ),
    GetPage(
      name: _Paths.SHARED_HISTORY,
      page: () => SharedHistoryView(),
      binding: SharedHistoryBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVED_HISTORY,
      page: () => ReceivedHistoryView(),
      binding: ReceivedHistoryBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.TERMS,
      page: () => TermsView(),
      binding: TermsBinding(),
    ),
  ];
}
