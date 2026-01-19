import 'package:flash_card/models/voca.dart';
import 'package:get/get.dart';
import '/./services/api_service.dart';

class VocaController extends GetxController {
  final _api = Get.find<ApiService>();
  // 상태 변수
  final RxList<Voca> myVocas = <Voca>[].obs;  // 내 단어장 리스트
  final RxBool isLoading = false.obs; // 로딩 중
  
  @override
  void onInit() {
    super.onInit();
    loadMyVocas(); // Controller 생성시 자동으로 단어장 로드
  }

  // 단어장 로드
  Future<void> loadMyVocas() async {
    isLoading.value = true;
    try {
      final data = await _api.getMyVocas();
      myVocas.value = data.map((json) => Voca.fromJson(json)).toList();
    } catch (e) {
      print(e);
      Get.snackbar('오류', '단어장을 불러올 수 없습니다');
    } finally {
      isLoading.value = false; // 성공이든 실패든 로딩 끝
    }
  }

  // 단어장 생성
  Future<bool> addVoca(String title) async {
    // 빈 내용 체크
    if (title.trim().isEmpty) return false;
    try {
      final res = await _api.addVoca(title);
      if (res.statusCode == 201) {
        await loadMyVocas(); // 목록 새로고침 (새 단어장이 보이도록)
        return true;
      }
    } catch (e) {
      Get.snackbar('오류', '단어장 생성 실패');
    }
    return false;
  }

  Future<void> updateVoca(int id, String newTitle) async {
    // 빈 제목 방지
    if (newTitle.trim().isEmpty) return;

    isLoading.value = true;
    try {
      // 수정 요청 api
      final success = await _api.updateVoca(id, newTitle);
      
      if (success) {
        // 성공 시 myVocas 리스트 갱신 (화면 즉시 반영)
        // 리스트에서 수정하려는 단어장이 몇 번째에 있는지 찾기
        final index = myVocas.indexWhere((v) => v.id == id);

        if (index != -1) {
          // 찾았으면, copyWith로 내용만 바꾼 새 단어장으로 교체!
          myVocas[index] = myVocas[index].copyWith(
            title: newTitle,
            updatedAt: DateTime.now(), // 수정 시간은 지금으로 갱신
          );
          
          // 뒤로가기 (작성/수정 화면 닫기) 및 알림
          Get.back(); 
          Get.snackbar('완료', '단어장이 수정되었습니다.');
        }
      }
    } catch (e) {
      Get.snackbar('오류', '수정 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 단어장 삭제
  Future<void> deleteVoca(int id) async {
    try {
      final success = await _api.deleteVoca(id);
      if (success) {
        // 로컬 목록에서 해당 단어장 제거
        myVocas.removeWhere((t) => t.id == id);
        Get.snackbar('완료', '단어장이 삭제되었습니다');
      }
    } catch (e) {
      Get.snackbar('오류', '삭제 실패');
    }
  }
}
