import 'package:get/get.dart';

// API 통신을 하기위한 기본 클래스
class ApiService extends GetConnect {
  String? _token; // 통신에 사용할 인증 토큰 저장

  @override
  void onInit() {
    // 서버 주소를 설정 (나중에 내 서버가 생기면 그쪽의 ip나 Domain으로 전환)
    httpClient.baseUrl = 'https://minix.jinhyung.kim/api';
    httpClient.timeout = const Duration(seconds: 30);

    // 토큰 자동 첨부
    httpClient.addRequestModifier<dynamic>((request) async {
      if (_token != null) {
        request.headers['Authorization'] = 'Bearer $_token';
      }
      return request;
    });

    super.onInit();
  }

  // 로그인 성공시 토큰 저장
  void setToken(String? token) {
    _token = token;
  }

  // 로그아웃시 토큰 삭제
  void clearToken() {
    _token = null;
  }

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

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final res = await post('/auth/login', {
      'email': email,
      'password': password,
    });
    if (res.statusCode == 200) {
      final token = res.body['token'];
      setToken(token); // 토큰 저장! (이후 요청에 자동첨부됨)
      return res.body['user']; // 유저 정보 반환
    }
    return null; // 로그인 실패
  }

  // 내 단어장 목록만 가져오기
  Future<List<dynamic>> getMyVocas() async {
    // 목데이터
    return [
      {
        "id": 1,
        "user_id": 101,
        "title": "토익 필수 영단어 100선",
        "created_at": "2024-01-10T10:00:00",
        "updated_at": "2024-01-14T12:30:00", // 수정일 있음
      },
      {
        "id": 2,
        "user_id": 101,
        "title": "여행용 일본어 회화",
        "created_at": "2024-01-12T09:00:00",
        "updated_at": null, // 수정일 없음
      },
      {
        "id": 3,
        "user_id": 101,
        "title": "CS 전공 면접 대비",
        "created_at": DateTime.now().toIso8601String(),
        "updated_at": null,
      },
    ];
    // 📝 [나중에 실제 서버 연결할 때 쓸 코드]
    // final res = await get('/users/me/vocas');

    // if (res.statusCode == 200) {
    //   return res.body['data'] ?? [];
    // }
    // return [];
  }

  // 단어장 생성
  Future<Response> createVoca(String title) async {
    return await post('/vocas', {'title': title});
  }

  // 단어장 수정
  Future<bool> editVoca(int id, String title) async {
    // 무조건 성공했다고 가정 (테스트용)
    return true;

    // 서버 연결용 코드
    // final res = await put('/vocas/$id', {'title': title});
    // return res.statusCode == 200;
  }

  // 단어장 삭제
  Future<bool> deleteVoca(int id) async {
    final res = await delete('/vocas/$id');
    return res.statusCode == 200;
  }

  // 단어 목록 조회
  Future<List<dynamic>> getWords(int vocaId) async {
    // 목데이터
    if (vocaId == 1) {
      return [
        {
          "id": 1,
          "voca_id": 1,
          "term": "Apple",
          "meaning": "사과",
          "created_at": DateTime.now().toIso8601String(),
        },
        {
          "id": 2,
          "voca_id": 1,
          "term": "Banana",
          "meaning": "바나나",
          "created_at": DateTime.now().toIso8601String(),
        },
        {
          "id": 3,
          "voca_id": 1,
          "term": "Computer",
          "meaning": "컴퓨터",
          "created_at": DateTime.now().toIso8601String(),
        },
      ];
    } else if (vocaId == 2) {
      return [
        {
          "id": 4,
          "voca_id": 2,
          "term": "hello",
          "meaning": "안녕하세요",
          "created_at": DateTime.now().toIso8601String(),
        },
        {
          "id": 5,
          "voca_id": 2,
          "term": "thank you",
          "meaning": "고맙습니다",
          "created_at": DateTime.now().toIso8601String(),
        },
      ];
    } else {
      return []; // 나머지는 빈 단어장
    }

    // 서버 연결용 코드
    /*
    final res = await get('/vocas/$vocaId/words');
    if (res.statusCode == 200) {
      return res.body['data'] ?? [];
    }
    return [];
    */
  }
}
