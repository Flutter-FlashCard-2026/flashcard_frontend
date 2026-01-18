import 'package:flash_card/controllers/voca_controller.dart';
import 'package:flash_card/models/voca.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocaFormSheet extends StatefulWidget {
  final VocaController vocaController;
  final Voca? voca; // null이면 추가 모드, 있으면 수정 모드

  const VocaFormSheet({
    super.key,
    required this.vocaController,
    this.voca,
  });

  @override
  State<VocaFormSheet> createState() => _VocaFormSheetState();
}

class _VocaFormSheetState extends State<VocaFormSheet> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    // 수정 모드면 기존 제목을 넣고, 아니면 빈칸
    titleController = TextEditingController(text: widget.voca?.title ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.voca != null;

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
            isEdit ? '단어장 이름 수정' : '새 단어장 만들기',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // 단어장 제목 입력
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: '단어장 이름',
              hintText: '예: 토익 필수 영단어',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.book),
            ),
            autofocus: true, // 창 열리면 바로 키보드 띄우기
          ),
          const SizedBox(height: 24),
          
          // 저장 버튼
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;

              if (isEdit) {
                // 수정 로직
                widget.vocaController.editVoca(
                  widget.voca!.id, 
                  titleController.text.trim()
                );
              } else {
                // 추가 로직
                widget.vocaController.createVoca(titleController.text.trim());
              }
              
              Get.back(); // 시트 닫기
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 179, 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isEdit ? '수정완료' : '만들기',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}