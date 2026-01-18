import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/widgets/word_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordListScreen extends StatelessWidget {
  const WordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wordController = Get.find<WordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('단어 목록 관리'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      
      // 단어 추가 버튼
      floatingActionButton: FloatingActionButton(
        // WordFormSheet를 호출. word가 null이면 추가 모드
        onPressed: () => Get.bottomSheet(
          WordFormSheet(controller: wordController, word: null),
          isScrollControlled: true,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 179, 0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      
      body: Obx(() {
        if (wordController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (wordController.words.isEmpty) {
          return const Center(child: Text("등록된 단어가 없습니다."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: wordController.words.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final word = wordController.words[index];

            return Dismissible(
              key: Key(word.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                wordController.deleteWord(word.id);
              },
              
              // 리스트 아이템
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                title: Text(
                  word.word,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  word.meaning,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                trailing: const Icon(Icons.edit, size: 18, color: Colors.grey),
                
                // 단어 수정 버튼
                onTap: () {
                  // word 객체를 넘겨주면 수정 모드
                  Get.bottomSheet(
                    WordFormSheet(controller: wordController, word: word),
                    isScrollControlled: true,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}