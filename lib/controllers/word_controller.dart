import 'package:flash_card/models/word.dart';
import 'package:flash_card/models/voca.dart';
import 'package:flash_card/services/api_service.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  final _api = Get.find<ApiService>();

  final Rxn<Voca> currentVoca = Rxn<Voca>();
  final RxList<Word> words = <Word>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 전달받은 단어장 정보가 있는지 확인
    if (Get.arguments != null) {
      currentVoca.value = Get.arguments as Voca;
      // 단어 불러오기
      loadWords();
    } else {
      print("단어장 정보 없음");
      Future.microtask(() {
        Get.offAllNamed('/voca');
      });
    }
  }

  Future<void> loadWords() async {
    // 단어장 정보가 없으면 실행 안 함
    if (currentVoca.value == null) return;

    isLoading.value = true;
    try {
      final data = await _api.getWords(currentVoca.value!.id);
      words.value = data.map((json) => Word.fromJson(json)).toList();
      print("단어장 ID: ${currentVoca.value!.id}, 가져온 단어 개수: ${words.length}");
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // 단어 추가
  Future<void> addWord(String wordText, String meaning) async {
    if (wordText.isEmpty || meaning.isEmpty) return;
    try {
      isLoading.value = true;

      // API 호출
      final res = await _api.addWord(currentVoca.value!.id, wordText, meaning);

      if (res.statusCode == 201) {
        await loadWords(); // 목록 새로고침
        Get.back(); // 입력창 닫기
        Get.snackbar("성공", "단어가 추가되었습니다.");
      } else {
        Get.snackbar("실패", "단어 추가 실패");
      }
    } catch (e) {
      print(e);
      Get.snackbar("오류", "네트워크 오류가 발생했습니다.");
    } finally {
      isLoading.value = false;
    }
  }

  // 단어 수정
  Future<void> updateWord(int wordId, String wordText, String meaning) async {
    try {
      isLoading.value = true;

      // API 호출
      final success = await _api.updateWord(wordId, wordText, meaning);

      if (success) {
        await loadWords(); // 목록 새로고침 (혹은 로컬 리스트만 수정해도 됨)
        Get.back(); // 입력창 닫기
        Get.snackbar("성공", "수정되었습니다.");
      } else {
        Get.snackbar("실패", "수정에 실패했습니다.");
      }
    } catch (e) {
      Get.snackbar("오류", "네트워크 오류");
    } finally {
      isLoading.value = false;
    }
  }

  // 단어 삭제
  Future<void> deleteWord(int wordId) async {
    try {
      // API 호출
      final success = await _api.deleteWord(wordId);

      if (success) {
        // 성공 시 리스트에서 즉시 제거 (새로고침보다 빠름)
        words.removeWhere((w) => w.id == wordId);
        Get.snackbar("삭제", "단어가 삭제되었습니다.");
      } else {
        Get.snackbar("실패", "삭제에 실패했습니다.");
      }
    } catch (e) {
      Get.snackbar("오류", "네트워크 오류");
    }
  }

  // 암기 상태 변경 (토글)
  Future<void> updateMemorizedStatus(int wordId, bool nextStatus) async {
    final index = words.indexWhere((w) => w.id == wordId);
    if (index == -1) return;

    final currentWord = words[index];

    if (currentWord.memorized == nextStatus) return;

    // 화면 먼저 갱신 (Optimistic Update)
    words[index] = currentWord.copyWith(memorized: nextStatus);

    // 백엔드 요청
    try {
      await _api.toggleMemorized(wordId);
    } catch (e) {
      // 실패하면 다시 원래대로 되돌림
      if (index != -1) {
        words[index] = currentWord; // 원래 상태로 복구
        Get.snackbar("오류", "상태 변경 실패");
      }
    }
  }

  // 암기 상태 초기화 함수
  Future<void> resetWordStatus() async {
    if (currentVoca.value == null) return;
    
    try {
      isLoading.value = true;
      final success = await _api.resetVocaStats(currentVoca.value!.id);
      
      if (success) {
        // 성공하면 목록을 서버에서 다시 받아옴
        await loadWords(); 
        
        Get.snackbar("완료", "모든 단어의 암기 상태가 초기화되었습니다.");
      } else {
        Get.snackbar("실패", "초기화에 실패했습니다.");
      }
    } catch (e) {
      Get.snackbar("오류", "네트워크 오류가 발생했습니다.");
    } finally {
      isLoading.value = false;
    }
  }
}
