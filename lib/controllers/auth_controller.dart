import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/./models/user.dart';
import '/./services/api_service.dart';

class AuthController extends GetxController {
  // ApiService 가져오기 (main.dart에서 등록한 것)
  final _api = Get.find<ApiService>();
  final box = GetStorage(); // GetStorage 인스턴스

  // 상태 변수들 (.obs = 관찰 가능)
  final Rx<User?> user = Rx<User?>(null); // 현재 로그인된 유저
  final RxBool isLoading = false.obs; // 로딩 중인지
  final RxString error = ''.obs; // 에러 메시지

  // 로그인 여부 확인
  bool get isLoggedIn => user.value != null;
  String? get token => box.read('token');

  @override
  void onInit() {
    super.onInit();
  }

  // 회원가입
  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    isLoading.value = true; // 로딩 시작
    error.value = ''; // 에러 초기화
    try {
      final res = await _api.register(
        email: email,
        password: password,
        name: name,
      );

      if (res.statusCode == 201) {
        return true; // 성공!
      } else {
        error.value = res.body['message'] ?? '회원가입 실패';
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      error.value = '네트워크 오류';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // 로그인
  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    error.value = ''; // 에러가 없으므로 비워둠

    try {
      final response = await _api.login(email: email, password: password);

      if (response.statusCode == 200) {
        final data = response.body;
        box.write('token', data['token']);
        user.value = User.fromJson(data['user']);
        return true;
      } else {
        error.value = response.body['message'] ?? '로그인에 실패했습니다';
        return false;
      }
    } catch (e) {
      error.value = '네트워크 오류가 발생했습니다';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // 로그아웃
  void logout() {
    box.remove('token');
    user.value = null; // 유저 정보 삭제
    Get.offAllNamed('/login'); // 로그인 화면으로 (뒤로가기 불가)
  }
}
