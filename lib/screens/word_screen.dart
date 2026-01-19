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
      backgroundColor: const Color(0xFFF5F5F5), // 배경색 살짝 회색
      // 메뉴바 연결
      drawer: _buildDrawer(context, wordController),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Obx(
          () => Text(
            wordController.currentVoca.value?.title ?? '단어장',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed('/login'),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (wordController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (wordController.words.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.style_outlined, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  "아직 등록된 단어가 없습니다.\n메뉴바를 눌러 단어를 추가해보세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Swiper(
            itemCount: wordController.words.length,
            viewportFraction: 0.8,
            scale: 0.9,
            layout: SwiperLayout.STACK,
            itemWidth: 350.0,
            itemBuilder: (BuildContext context, int index) {
              final word = wordController.words[index];
              return WordCard(
                word: word.word,
                meaning: word.meaning,
                memorized: word.memorized,
                onDontKnow: () {
                  wordController.updateMemorizedStatus(word.id, false);
                },
                onKnow: () {
                  wordController.updateMemorizedStatus(word.id, true);
                },
              );
            },
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(color: Colors.grey),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20),
            ),
          ),
        );
      }),
    );
  }

  // 메뉴바
  Widget _buildDrawer(BuildContext context, WordController controller) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFB300),
                  Color(0xFFFF8F00),
                ], // 노랑 -> 주황 그라데이션
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30), // 오른쪽 아래만 둥글게
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  "현재 학습 중",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 5),
                // 현재 단어장 이름 표시
                Obx(
                  () => Text(
                    controller.currentVoca.value?.title ?? '단어장',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 메뉴 리스트
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey,
                  ),
                  title: const Text('단어장 목록으로 나가기'),
                  onTap: () {
                    Get.back(); // 드로어 닫기
                    Get.back(); // 이전 화면으로 돌아가기
                  },
                ),

                const Divider(indent: 20, endIndent: 20), // 구분선

                ListTile(
                  leading: const Icon(
                    Icons.format_list_bulleted,
                    color: Colors.blueAccent,
                  ),
                  title: const Text('단어 목록 관리'),
                  subtitle: const Text('추가, 수정 및 삭제'),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/wordList');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.quiz_outlined,
                    color: Colors.purpleAccent,
                  ),
                  title: const Text('암기 상태 확인'),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/study');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.refresh, color: Colors.green),
                  title: const Text('암기 상태 초기화'),
                  onTap: () {
                    Get.back();
                    // TODO: 초기화 로직
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
