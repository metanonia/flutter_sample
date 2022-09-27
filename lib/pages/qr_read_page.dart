import 'package:barcode_scan2/gen/protos/protos.pb.dart';
import 'package:barcode_scan2/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan2/model/android_options.dart';
import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/qr_read_page_controller.dart';

class QrReadPage extends GetView<QrReadPageController> {
  QrReadPage({Key? key}) : super(key: key);

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];



  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: const Text('QR Read', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: ListView(
            children: [
              Center(
                child: Obx(() => Text(
                  controller.scanResult.value,
                  ),
                ),
              ),
              IconButton(onPressed: _scan, icon: Icon(Icons.camera)),
            ]
        )
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': controller.cancel,
            'flash_on': controller.flashOn,
            'flash_off': controller.flashOff,
          },
          restrictFormat: selectedFormats,
          useCamera: 0,
          autoEnableFlash: false,
          android: const AndroidOptions(
            aspectTolerance: 0.00,
            useAutoFocus: true,
          ),
        ),
      );
      controller.scanResult.value = result.rawContent;
    } on PlatformException catch (e) {
        controller.scanResult.value = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        ).rawContent;
    }
  }
}