import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controller/qr_page_controller.dart';

class QrPage extends GetView<QrPageController> {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(

        appBar: AppBar(
          title: Text('QR Text', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: ListView(
            children: [
              Container(
                height: 60,
                alignment: Alignment.center,
                child: Text('QR용 문장을 입력하세요.', style: TextStyle(fontSize: 20),),
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Hint',
                  )
                )
              ),
              Center(
                child: Obx(() => QrImage(
                    data: '${controller.qrText.value}',
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                ),
              ),
              FloatingActionButton(
                  child:Icon(Icons.print),
                  onPressed: () {
                        controller.qrText.value = textController.text;
                  }
              )
            ]
        )
    );
  }
  
}