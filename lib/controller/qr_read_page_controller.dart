import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';

class QrReadPageController extends GetxController {
  String cancel = 'Cancel';
  String flashOn = "Flash On";
  String flashOff = 'Flash Off';
  RxString scanResult = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}