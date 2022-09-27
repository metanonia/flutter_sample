import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/web_view_page_controller.dart';

class WebViewPage extends GetView<WebViewPageController> {
  WebViewController? _controller;
  WebViewPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ElevatedButton(
              child: Text('send to Javascript'),
              onPressed: () {
                if (_controller != null) {
                  var now = new DateTime.now();
                  _controller!.runJavascript(
                      'window.fromFlutter("this is title from Flutter '+ now.toIso8601String() + '")');
                }
              },
            )),
        body: WebView(
          initialUrl: "abount:blank",
          onWebViewCreated: (WebViewController webviewController) {
            _controller = webviewController;
            _loadHtmlFromAssets();
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'JavaScriptChannel',
                onMessageReceived: (JavascriptMessage message) {
                  print(message.message);
                })
          ]),
        ));
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/WebViewTest.html');
    _controller!.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}