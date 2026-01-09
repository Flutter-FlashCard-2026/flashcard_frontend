import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
        title: const Text('트윗 작성'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('트윗'),),
        ],
      ),
      body: const Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: TextField(
          maxLines: 5,
          maxLength: 280,
          decoration: InputDecoration(
            hintText: '무슨 일이 일어나고 있나요?',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}