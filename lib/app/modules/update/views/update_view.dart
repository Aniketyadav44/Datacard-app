import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_controller.dart';

class UpdateView extends GetView<UpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
