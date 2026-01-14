import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/widgets/word_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';

class WordScreen extends StatelessWidget {
  const WordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wordController = Get.find<WordController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // TODO: 단어 추가 화면으로 이동 (나중에 구현)
        onPressed: () {}, 
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Obx(() => Text(wordController.currentVoca.value?.title ?? '단어장')),
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
      body: Obx(() {
        // 로딩바
        if (wordController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (wordController.words.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.note_alt_outlined, size: 60, color: Colors.grey),
                const SizedBox(height: 16),
                const Text("아직 등록된 단어가 없습니다.\n+ 버튼을 눌러 단어를 추가해보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        // 단어가 있으면 카드 보여주기
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Swiper(
            itemCount: wordController.words.length,
            viewportFraction: 0.8,
            scale: 0.9,
            layout: SwiperLayout.STACK,
            itemWidth: 350.0,
            
            // 여기서 데이터를 하나씩 꺼내서 카드에 넣어줌
            itemBuilder: (BuildContext context, int index) {
              final word = wordController.words[index]; // 리스트에서 하나 꺼냄
              
              return WordCard(
                word: word.term,
                meaning: word.meaning,
              );
            },
            
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Color.fromARGB(255, 239, 178, 88),
                color: Colors.grey,
              ),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20)
            ),
          ),
        );
      }),
    );
  }
}