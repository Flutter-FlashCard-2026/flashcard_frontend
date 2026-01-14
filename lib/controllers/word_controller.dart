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
}
