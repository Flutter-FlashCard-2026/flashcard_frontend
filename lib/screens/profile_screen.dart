import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash_card/screens/webview_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              '홍길동',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {},
              child: const Text('프로필 수정'),
            ),
            TextButton(
              onPressed: () => Get.offAllNamed('/login'),
              child: const Text(
              '로그아웃',
              style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.description),
              title: const Text('이용약관'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.to(() => const WebviewScreen(
                title: '이용약관',
                url: 'https://tukorea.ac.kr'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}