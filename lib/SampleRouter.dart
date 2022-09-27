import 'package:flutter_sample/pages/home_page.dart';
import 'package:flutter_sample/pages/mmist_page.dart';
import 'package:flutter_sample/pages/qr_page.dart';
import 'package:flutter_sample/pages/qr_read_page.dart';
import 'package:get/get.dart';

class SampleRouter {
  static final route = [
    GetPage(
      name: '/',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/qrcode',
      page: () => QrPage(),
    ),
    GetPage(
      name: '/qrread',
      page: () => QrReadPage(),
    ),
    GetPage(
      name: '/mmist',
      page: () => MmistPage(),
    ),
  ];
}