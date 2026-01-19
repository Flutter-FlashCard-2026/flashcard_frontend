import 'package:card_swiper/card_swiper.dart';
import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/widgets/study_card.dart'; // 방금 만든 위젯 import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wordController = Get.find<WordController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("암기 상태 확인"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        foregroundColor: Colors.black, // 글자색 검정
      ),
      body: Obx(() {
        if (wordController.words.isEmpty) {
          return const Center(child: Text("단어가 없습니다."));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Swiper(
            itemCount: wordController.words.length,
            viewportFraction: 0.8,
            scale: 0.9,
            layout: SwiperLayout.STACK,
            itemWidth: 350.0,
            itemBuilder: (context, index) {
              return StudyCard(word: wordController.words[index]);
            },
            
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.blueAccent,
                color: Colors.grey,
              ),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20),
            ),
          ),
        );
      }),
    );
  }
}