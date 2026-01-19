import 'package:flash_card/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller 가져오기
  final _authController = Get.find<AuthController>();

  // 입력창 컨트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 로그인 버튼 눌렀을 때
  Future<void> _login() async {
    // AuthController의 login() 호출
    final success = await _authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (success) {
      Get.offAllNamed('/voca');
    } else {
      // 실패시 에러 메시지 표시
      Get.snackbar('로그인 실패', _authController.error.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 로고
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // 빈 공간
              const Text(
                'MemoryWord',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48), // 빈 공간
              // 이메일 입력
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),

              // 비밀번호 입력
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),

              // 로그인 버튼
              Obx(
                () => ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: _authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('로그인'),
                ),
              ),
              const SizedBox(height: 16),

              // 회원가입 링크
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text('계정이 없으신가요? 회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
