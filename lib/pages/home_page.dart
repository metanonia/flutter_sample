import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sampe', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Get.toNamed('/qrcode'),
                child: Text('QR CODE')
            ),
            ElevatedButton(
                onPressed: () => Get.toNamed('/qrread'),
                child: Text('QR Read')
            ),
            ElevatedButton(
                onPressed: () => Get.toNamed('/mmist'),
                child: Text('MMIST')
            ),
          ],
        )

      )
    );
  }
  
}