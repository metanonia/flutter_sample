import 'package:flutter_sample/component/binance_price.dart';
import 'package:get/get.dart';

class RestPageController extends GetxController {
  final priceList = RxList<BinancePrice>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}