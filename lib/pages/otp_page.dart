import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:base32/base32.dart';

import '../controller/home_page_controller.dart';
import '../controller/otp_page_controller.dart';

class OtpPage extends GetView<OtpPageController> {

  @override
  Widget build(BuildContext context) {

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
                onPressed: () {
                  final enkey = base32.encodeHexString('48656c6c6f21deadbeef');
                  print('Google OTP에 등록해야 하는 키: ' + enkey);
                  // Encode a hex string to base32
                  final org = base32.decodeAsHexString("JBSWY3DPEHPK3PXP");
                  print('ORG: ' + org);
                  // 구글 OTP에서 나오는 값과 동일한 값이어야 한다.
                  final code = OTP.generateTOTPCodeString(
                      'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch,
                      length: 6,
                      interval: 30,
                      algorithm: Algorithm.SHA1,
                      isGoogle: true);
                  print(code);
                },
                child: Text('OTP')
            ),

          ],
        )

      )
    );
  }
  
}