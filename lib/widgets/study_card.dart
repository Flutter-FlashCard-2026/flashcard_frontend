import 'package:flash_card/models/word.dart';
import 'package:flutter/material.dart';

class StudyCard extends StatefulWidget {
  final Word word;

  const StudyCard({super.key, required this.word});

  @override
  State<StudyCard> createState() => _StudyCardState();
}

class _StudyCardState extends State<StudyCard> {
  // 뜻이 보이는지 여부
  bool isRevealed = false;

  @override
  void didUpdateWidget(covariant StudyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 카드가 바뀌면 상태를 다시 가림으로 초기화
    if (oldWidget.word.id != widget.word.id) {
      isRevealed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 단어
          Text(
            widget.word.word,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),

          // 뜻
          if (!isRevealed) ...[
            // 숨김 상태
            GestureDetector(
              onTap: () {
                setState(() {
                  isRevealed = true; // 버튼 누르면 보이게 변경
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "단어 확인하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
            ),
          ] else ...[
            // 공개 상태: 뜻 표시
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.word.meaning,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}