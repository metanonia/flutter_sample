import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../component/Prediction.dart';
import '../service/recognizer.dart';

class MmistPageController extends GetxController {
  final points = RxList<Offset?>();
  final prediction = RxList<Prediction>();
  Recognizer recognizer = Recognizer();


  @override
  void onInit() {
    recognizer.loadModel();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}