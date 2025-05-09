import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mas_market/Pages/auth/sign_in.dart';
import 'package:mas_market/Pages/main/On%20Bording/on_bording.dart';
import 'package:mas_market/core/service/auth_service.dart';
import 'package:mas_market/core/theme/app_colors.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:mq_market/Services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpqbmducnJtYWF3ZWFobm51a3FxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYzNzE1MTAsImV4cCI6MjA2MTk0NzUxMH0.D6ZJSXtBNVHyXiH8RDb3pyet0G-D5axw5E3tROAkwXc',
    url: 'https://zjngnrrmaaweahnnukqq.supabase.co',
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
        ),
      ),

      home: AuthService().isLoggedIn() ? OnBording() : SignIn(),
      // home: authService.isLoggedIn() ? OnBordingHomePage() : SignIn(),
    );
  }
}
