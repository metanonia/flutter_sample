import 'package:flutter_sample/controller/home_page_controller.dart';
import 'package:flutter_sample/controller/mnist_page_controller.dart';
import 'package:flutter_sample/controller/qr_page_controller.dart';
import 'package:flutter_sample/controller/qr_read_page_controller.dart';
import 'package:flutter_sample/controller/web_view_page_controller.dart';
import 'package:flutter_sample/pages/home_page.dart';
import 'package:flutter_sample/pages/mnist_page.dart';
import 'package:flutter_sample/pages/qr_page.dart';
import 'package:flutter_sample/pages/qr_read_page.dart';
import 'package:flutter_sample/pages/web_view_page.dart';
import 'package:get/get.dart';

class SampleRouter {
  static final route = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomePageController>(() => HomePageController());
      }),
    ),
    GetPage(
      name: '/qrcode',
      page: () => QrPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QrPageController>(() => QrPageController());
      }),
    ),
    GetPage(
      name: '/qrread',
      page: () => QrReadPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QrReadPageController>(() => QrReadPageController());
      }),
    ),
    GetPage(
      name: '/mmist',
      page: () => MnistPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MnistPageController>(() => MnistPageController());
      }),
    ),
    GetPage(
      name: '/webview',
      page: () => WebViewPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WebViewPageController>(() => WebViewPageController());
      }),
    ),
  ];
}