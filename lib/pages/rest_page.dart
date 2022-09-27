import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sample/component/binance_price.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/rest_page_controller.dart';

class RestPage extends GetView<RestPageController> {
  RestPage({Key? key}) : super(key: key);
  late Future<List<BinancePrice>>priceList;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(

        appBar: AppBar(
          title: Text('Get Binance BTC Price', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Obx(() =>ListView.builder(
              itemCount: controller.priceList.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return Container(
                  height: 50,
                  color: Colors.amber,
                  child: Center(child: Text(controller.priceList[idx].symbol + ' : ' + controller.priceList[idx].price)),
                );
              }
          ),
        ),
      floatingActionButton: FloatingActionButton(
          child:Icon(Icons.print),
          onPressed: () async {
            controller.priceList.value =  await _fetchData();
          }
      ),
    );
  }

  Future<List<BinancePrice>> _fetchData()  async {
    final response = await http.get(Uri.parse('https://api.binance.com/api/v3/ticker/price'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<BinancePrice> list = List<BinancePrice>.from(l.map((model)=> BinancePrice.fromJson(model)));
      return list;
    } else {

      throw Exception('Failed to load Data');
    }
  }

}