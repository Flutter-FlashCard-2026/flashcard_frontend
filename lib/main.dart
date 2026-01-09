import 'package:flutter/material.dart';
import 'app.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  // Flutter 엔진과 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 한국어 설정
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  // 앱 실행  
  runApp(const MyApp());
}
