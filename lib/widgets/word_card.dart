import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String eng; // 영어 단어
  final String kor; // 한글 뜻

  const WordCard({
    super.key,
    required this.eng,
    required this.kor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            eng,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          
          Container(
            width: 50,
            height: 2,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),

          Text(
            kor,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}