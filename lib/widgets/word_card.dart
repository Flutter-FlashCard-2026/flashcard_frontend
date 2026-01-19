import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String meaning;
  final bool memorized; // 암기 여부 (색상 표시용)
  final VoidCallback onKnow; // '알아요' 버튼 클릭 시
  final VoidCallback onDontKnow; // '몰라요' 버튼 클릭 시

  const WordCard({
    super.key,
    required this.word,
    required this.meaning,
    required this.memorized,
    required this.onKnow,
    required this.onDontKnow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        // 암기 완료된 카드는 테두리에 초록색 표시
        border: memorized 
            ? Border.all(color: Colors.green.withOpacity(0.5), width: 3) 
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 단어와 뜻
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  word,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  meaning,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (memorized) ...[
                  const SizedBox(height: 10),
                  const Chip(
                    label: Text("암기 완료!", style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  )
                ]
              ],
            ),
          ),

          // 하단 O/X 버튼 영역
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 몰라요 버튼
                _buildActionButton(
                  icon: Icons.close,
                  color: Colors.redAccent,
                  label: "몰라요",
                  onTap: onDontKnow,
                ),
                
                // 알아요 버튼
                _buildActionButton(
                  icon: Icons.check,
                  color: Colors.green,
                  label: "알아요",
                  onTap: onKnow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 버튼 만드는 함수
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}