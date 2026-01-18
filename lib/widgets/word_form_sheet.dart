import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/models/word.dart';
import 'package:flutter/material.dart';

class WordFormSheet extends StatefulWidget {
  final WordController controller;
  final Word? word;

  const WordFormSheet({
    super.key,
    required this.controller,
    this.word, // null이면 추가 모드, 있으면 수정 모드
  });

  @override
  State<WordFormSheet> createState() => _WordFormSheetState();
}

class _WordFormSheetState extends State<WordFormSheet> {
  late TextEditingController termController;
  late TextEditingController meaningController;

  @override
  void initState() {
    super.initState();
    final isEdit = widget.word != null;
    // 기존 데이터가 있으면 채워넣기
    termController = TextEditingController(text: isEdit ? widget.word?.word : '');
    meaningController = TextEditingController(text: isEdit ? widget.word?.meaning : '');
  }

  @override
  void dispose() {
    termController.dispose();
    meaningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.word != null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isEdit ? '단어 수정' : '새 단어 추가',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // 영어 단어 입력
          TextField(
            controller: termController,
            decoration: const InputDecoration(
              labelText: '단어 (영어)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.abc),
            ),
            autofocus: true, 
          ),
          const SizedBox(height: 16),
          
          // 뜻 입력
          TextField(
            controller: meaningController,
            decoration: const InputDecoration(
              labelText: '뜻 (한글)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.translate),
            ),
          ),
          const SizedBox(height: 24),
          
          // 저장 버튼
          ElevatedButton(
            onPressed: () {
              if (termController.text.isEmpty || meaningController.text.isEmpty) return;

              if (isEdit) {
                // 수정
                widget.controller.updateWord(
                  widget.word!.id, 
                  termController.text, 
                  meaningController.text
                );
              } else {
                // 추가
                widget.controller.addWord(
                  termController.text, 
                  meaningController.text
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 179, 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isEdit ? '수정하기' : '추가하기',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}