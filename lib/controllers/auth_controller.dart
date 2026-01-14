import 'package:get/get.dart';
import '/./models/user.dart';
import '/./services/api_service.dart';

class AuthController extends GetxController {
  // ApiService 가져오기 (main.dart에서 등록한 것)
  final _api = Get.find<ApiService>();

  // 상태 변수들 (.obs = 관찰 가능)
  final Rx<User?> user = Rx<User?>(null); // 현재 로그인된 유저
  final RxBool isLoading = false.obs; // 로딩 중인지
  final RxString error = ''.obs; // 에러 메시지

  // 로그인 여부 확인
  bool get isLoggedIn => user.value != null;

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
      isLoading.value = false; // 로딩 끝
      if (res.statusCode == 201) {
        return true; // 성공! → 로그인 화면으로 이동
      } else {
        error.value = res.body['message'] ?? '회원가입 실패';
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      error.value = '네트워크 오류';
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    error.value = ''; // 에러가 없으므로 비워둠
    try {
      final userData = await _api.login(email: email, password: password);
      isLoading.value = false;
      if (userData != null) {
        // JSON → User 객체로 변환해서 저장
        user.value = User.fromJson(userData);
        return true;
      } else {
        error.value = '이메일 또는 비밀번호가 올바르지 않습니다';
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      error.value = '네트워크 오류';
      return false;
    }
  }

  void logout() {
    user.value = null; // 유저 정보 삭제
    _api.clearToken(); // 토큰 삭제
    Get.offAllNamed('/login'); // 로그인 화면으로 (뒤로가기 불가)
  }
}
