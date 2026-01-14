import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word; // 단어
  final String meaning; // 뜻

  const WordCard({
    super.key,
    required this.word,
    required this.meaning,
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
            word,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
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
            meaning,
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