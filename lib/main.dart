import 'package:flash_card/controllers/auth_controller.dart';
import 'package:flash_card/controllers/voca_controller.dart';
import 'package:flash_card/controllers/word_controller.dart';
import 'package:flash_card/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  // flutter 바인딩
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // 의존성 주입
  Get.put(ApiService());                  // 1. API 서비스 
  Get.put(AuthController());              // 2. 인증 컨트롤러
  Get.lazyPut(() => VocaController(), fenix: true);
  Get.lazyPut(() => WordController(), fenix: true);

  // 한국어 설정
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  // 앱 실행  
  runApp(const MyApp());
}
