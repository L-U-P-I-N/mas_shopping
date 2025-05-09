import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:mas_market/Pages/auth/sign_in.dart';
import 'package:mas_market/Pages/app/main/On%20Bording/on_bording.dart';
// import 'package:mq_market/Pages/auth/sign_in.dart';
// import 'package:mq_market/Pages/main/On%20Bording/on_bording.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final box = GetStorage();

  // تسجيل الدخول
  Future<void> signIn(String email, String password, bool rememberMe) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        if (rememberMe) {
          await box.write('remember_me', true);
        } else {
          await box.remove('remember_me');
        }
        Get.offAll(OnBording());
      }
    } catch (e) {
      print("Login Error: $e");
    }
  }

  // إنشاء حساب
  Future<void> signUp(String email, String password) async {
    try {
      await _supabase.auth.signUp(email: email, password: password);
      Get.offAll(SignIn());
    } catch (e) {
      print("Sign Up Error: $e");
      GetSnackBar(message: 'Error in Create Acount');
    }
  }

  // نسيان كلمة السر
  Future<bool> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return true;
    } catch (e) {
      print("Reset Password Error: $e");
      GetSnackBar(message: 'Error in Reset Password');
      return false;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    await box.remove('remember_me');
  }

  // التحقق من الجلسة
  bool isLoggedIn() {
    final session = _supabase.auth.currentSession;
    final rememberMe = box.read('remember_me') ?? false;
    return session != null && rememberMe;
  }
}
