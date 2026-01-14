import 'package:flash_card/controllers/auth_controller.dart';
import 'package:flash_card/controllers/voca_controller.dart';
import 'package:flash_card/widgets/voca_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocaScreen extends StatelessWidget {
  const VocaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vocaController = Get.find<VocaController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/compose'),
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text('단어장 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (vocaController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 내 단어장이 하나도 없을 때 안내 문구
        if (vocaController.myVocas.isEmpty) {
          return const Center(child: Text("아직 단어장이 없어요!"));
        }

        return ListView.separated(
          itemCount: vocaController.myVocas.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final voca = vocaController.myVocas[index];
            return VocaCard(
              voca: voca,
              // arguments에 voca를 담아서 보내면, 수정 모드로 인식
              onEdit: () {
                Get.toNamed('/compose', arguments: voca);
              },
              onDelete: () {
                vocaController.deleteVoca(voca.id);
              },
            );
          },
        );
      }),
    );
  }
}
