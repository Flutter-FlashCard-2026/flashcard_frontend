import 'package:flash_card/widgets/word_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 데이터
    final List<Map<String, String>> words = [
      {'eng': '토익 단어장', 'kor': '사과'},
      {'eng': '코딩 용어 단어장', 'kor': '바나나'},
      {'eng': 'JVM', 'kor': 'Java Virtual Machine'},
      {'eng': 'Flutter', 'kor': '플러터'},
      {'eng': 'Dart', 'kor': '다트'},
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/compose'),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('MemoryWord'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/profile'),
            icon: const Icon(Icons.person)
          ),
          IconButton(
            onPressed: () => Get.offAllNamed('/login'),
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Swiper(
          itemCount: words.length,
          viewportFraction: 0.8, 
          scale: 0.9, 
          layout: SwiperLayout.STACK,
          itemWidth: 350.0,
          itemBuilder: (BuildContext context, int index) {
            return WordCard(
              word: words[index]['eng']!,
              meaning: words[index]['kor']!
            );
          },
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.indigo,
              color: Colors.grey,
            ),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20)
          ),
        ),
      ),
    );
  }
}