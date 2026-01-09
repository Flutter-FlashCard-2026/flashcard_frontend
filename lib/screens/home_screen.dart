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
      {'eng': 'Apple', 'kor': '사과'},
      {'eng': 'Banana', 'kor': '바나나'},
      {'eng': 'Computer', 'kor': '컴퓨터'},
      {'eng': 'Flutter', 'kor': '플러터'},
      {'eng': 'Dart', 'kor': '다트'},
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/compose'),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Memory Word'),
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
              eng: words[index]['eng']!,
              kor: words[index]['kor']!
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