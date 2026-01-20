import 'package:card_swiper/card_swiper.dart';
import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final wordController = Get.find<WordController>();

  @override
  void initState() {
    super.initState();
    // 화면 들어오자마자 안 외운 단어 불러오기
    wordController.loadStudyWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("암기 학습"), // 제목 변경
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (wordController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 공부할 단어가 없을 때 (다 외웠을 때)
        if (wordController.studyWords.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_outlined, size: 80, color: Colors.amber),
                const SizedBox(height: 16),
                const Text(
                  "모든 단어를 외우셨습니다!\n정말 대단해요 👍",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("돌아가기"),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Swiper(
            itemCount: wordController.studyWords.length,
            viewportFraction: 0.8,
            scale: 0.9,
            loop: false,
            itemBuilder: (context, index) {
              return StudyCard(word: wordController.studyWords[index]);
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