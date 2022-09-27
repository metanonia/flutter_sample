import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as im;

import '../component/Prediction.dart';
import '../component/constants.dart';
import '../component/drawing_painter.dart';
import '../component/prediction_widget.dart';
import '../controller/mmist_page_controller.dart';
import '../service/recognizer.dart';

class MmistPage extends GetView<MmistPageController> {

  @override
  Widget build(BuildContext context) {
    final MmistPageController controller = Get.put(MmistPageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Digit Recognizer'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'MNIST database of handwritten digits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The digits have been size-normalized and centered in a fixed-size images (28 x 28)',
                      )
                    ],
                  ),
                ),
              ),
              _mnistPreviewImage(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _drawCanvasWidget(),
          SizedBox(
            height: 10,
          ),
          Obx(()=>PredictionWidget(
              predictions: controller.prediction.value,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
            controller.points.clear();
            controller.prediction.clear();
        },
      ),
    );
  }

  Widget _drawCanvasWidget() {
    return Container(
      width: Constants.canvasSize + Constants.borderSize * 2,
      height: Constants.canvasSize + Constants.borderSize * 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: Constants.borderSize,
        ),
      ),
      child: Obx(() => GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          Offset _localPosition = details.localPosition;
          if (_localPosition.dx >= 0 &&
              _localPosition.dx <= Constants.canvasSize &&
              _localPosition.dy >= 0 &&
              _localPosition.dy <= Constants.canvasSize) {
              controller.points.value.add(_localPosition);
          }
        },
        onPanEnd: (DragEndDetails details) {
          controller.points.add(null);
          _recognize();
        },
        child: CustomPaint(
          painter: DrawingPainter(controller.points.value),
        ),
      ),
      ),
    );
  }

  Future<Uint8List> _previewImage() async {
    return await controller.recognizer.previewImage(controller.points.value);
  }

  Widget _mnistPreviewImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: Obx(() => FutureBuilder(
        future: _previewImage(),
        builder: (BuildContext _, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data as Uint8List,
              fit: BoxFit.fill,
            );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
      ),
    );
  }

  void _recognize() async {
    List<dynamic> pred = await controller.recognizer.recognize(controller.points.value);
    print(pred);
    controller.prediction.value = pred.map((json) => Prediction.fromJson(json)).toList();
  }
}