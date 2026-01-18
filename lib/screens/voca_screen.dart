import 'package:flash_card/controllers/auth_controller.dart';
import 'package:flash_card/controllers/voca_controller.dart';
import 'package:flash_card/widgets/voca_card.dart';
import 'package:flash_card/widgets/voca_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocaScreen extends StatelessWidget {
  const VocaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vocaController = Get.find<VocaController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      
      // 단어장 추가 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // voca: null -> 추가 모드
          Get.bottomSheet(
            VocaFormSheet(vocaController: vocaController, voca: null),
            isScrollControlled: true, // 키보드 올라올 때 시트도 같이 올라가게
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("단어장 추가", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      
      appBar: AppBar(
        title: const Text('내 단어장'),
        centerTitle: true,
        elevation: 0,
        actions: [
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

        if (vocaController.myVocas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.library_books_outlined, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text("아직 단어장이 없어요!\n아래 버튼을 눌러 만들어보세요.", 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16), // 리스트 전체 여백
          itemCount: vocaController.myVocas.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12), // 구분선 대신 여백
          itemBuilder: (context, index) {
            final voca = vocaController.myVocas[index];
            return VocaCard(
              voca: voca,
              
              // 수정 버튼
              onEdit: () {
                // voca 전달 -> 수정 모드
                Get.bottomSheet(
                  VocaFormSheet(vocaController: vocaController, voca: voca),
                  isScrollControlled: true,
                );
              },
              
              onDelete: () {
                 // 삭제 전 확인 다이얼로그
                 Get.defaultDialog(
                    title: "단어장 삭제",
                    middleText: "'${voca.title}'을(를) 삭제하시겠습니까?\n안에 있는 단어도 모두 삭제됩니다.",
                    textConfirm: "삭제",
                    textCancel: "취소",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    onConfirm: () {
                      vocaController.deleteVoca(voca.id);
                      Get.back(); // 다이얼로그 닫기
                    }
                 );
              },
            );
          },
        );
      }),
    );
  }
}