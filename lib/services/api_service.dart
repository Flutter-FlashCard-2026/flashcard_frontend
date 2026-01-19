import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// API 통신을 하기위한 기본 클래스
class ApiService extends GetConnect {
  final box = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:3000/api';

    // 요청 인터셉터 - 토큰 자동 추가
    httpClient.addRequestModifier<dynamic>((request) {
      final token = box.read('token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    // 응답 인터셉터
    httpClient.addResponseModifier((request, response) {
      // 401 에러시 로그아웃 처리
      if (response.statusCode == 401) {
        box.remove('token');
        box.remove('user');
        Get.offAllNamed('/login');
      }
      return response;
    });

    super.onInit();
  }

  // 로그인 성공시 토큰 저장
  void setToken(String? token) {
    box.write('token', token);
  }

  // 로그아웃시 토큰 삭제
  void clearToken() {
    box.remove('token');
  }

  // ==================== 인증 ====================

  // 회원가입
  Future<Response> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return await post('/auth/register', {
      'email': email,
      'password': password,
      'name': name,
    });
  }

  // 로그인
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await post('/auth/login', {'email': email, 'password': password});
  }

  // 내 단어장 목록만 가져오기
  Future<List<dynamic>> getMyVocas() async {
    final res = await get('/vocas');

    if (res.statusCode == 200) {
      return res.body ?? [];
    }
    return [];
  }

  // 단어장 생성
  Future<Response> addVoca(String title) async {
    return await post('/vocas', {'title': title});
  }

  // 단어장 수정
  Future<bool> updateVoca(int id, String title) async {
    final res = await put('/vocas/$id', {'title': title});
    return res.statusCode == 200;
  }

  // 단어장 삭제
  Future<bool> deleteVoca(int id) async {
    final res = await delete('/vocas/$id');
    return res.statusCode == 200;
  }

  // ============ 단어 ==============
  // 1. 단어 목록 조회
  Future<List<dynamic>> getWords(int vocaId) async {
    final res = await get('/vocas/$vocaId/words');
    
    if (res.statusCode == 200) {
      return res.body ?? [];
    }
    return [];
  }

  // 2. 단어 추가
  // POST /vocas/:vocaId/words
  // Body: { word, meaning }
  Future<Response> addWord(int vocaId, String word, String meaning) async {
    return await post('/vocas/$vocaId/words', {
      'word': word,
      'meaning': meaning,
    });
  }

  // 3. 단어 수정
  // PUT /words/:wordId
  // Body: { word, meaning }
  Future<bool> updateWord(int wordId, String word, String meaning) async {
    final res = await put('/words/$wordId', {
      'word': word,
      'meaning': meaning,
    });
    return res.statusCode == 200;
  }

  // 4. 단어 삭제
  // DELETE /words/:wordId
  Future<bool> deleteWord(int wordId) async {
    final res = await delete('/words/$wordId');
    return res.statusCode == 200;
  }

  // 5. 암기 상태 변경
  // PATCH /words/:wordId
  Future<bool> toggleMemorized(int wordId) async {
    final res = await patch('/words/$wordId', {});
    return res.statusCode == 200;
  }
}
