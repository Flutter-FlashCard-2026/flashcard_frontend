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

  // 단어 암기 상태 체크용
  void updateMemorizedStatus(int wordId, bool memorized) {
    final index = words.indexWhere((w) => w.id == wordId);
    if (index != -1) {
      words[index] = words[index].copyWith(memorized: memorized);
    }

    // 2. (나중에 구현) 서버나 DB에도 저장
    // _repository.updateStatus(wordId, isMemorized);
  }

  // 단어 추가
    Future<void> addWord(String term, String meaning) async {
      try {
        isLoading.value = true;
        // TODO: 백엔드 API 호출 (POST /vocas/:id/words)
        // await _api.addWord(currentVoca.value!.id, term, meaning);

        // UI 테스트용 가짜 데이터 추가 (나중에 API 연결 후 삭제)
        // words.add(Word(id: 999, term: term, meaning: meaning, ...));

        // await getWords(currentVoca.value!.id); // 목록 새로고침
        Get.back(); // 창 닫기
        Get.snackbar("성공", "단어가 추가되었습니다.");
      } catch (e) {
        // 에러 처리
      } finally {
        isLoading.value = false;
      }
    }

    // 단어 수정
    Future<void> updateWord(int wordId, String term, String meaning) async {
      try {
        // TODO: 백엔드 API 호출 (PUT /words/:id)
        // await getWords(currentVoca.value!.id); // 목록 새로고침
        Get.back(); // 창 닫기
        Get.snackbar("성공", "단어가 수정되었습니다.");
      } catch (e) {
        // 에러 처리
      }
    }

    // 단어 삭제
    Future<void> deleteWord(int wordId) async {
      try {
        // TODO: 백엔드 API 호출 (DELETE /words/:id)
        // await _api.deleteWord(wordId);

        // UI 즉시 반영 (리스트에서 제거)
        words.removeWhere((w) => w.id == wordId);
      } catch (e) {
        Get.snackbar("오류", "삭제에 실패했습니다.");
      }
    }
}
