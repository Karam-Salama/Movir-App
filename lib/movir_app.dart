import 'package:flutter/material.dart';
import 'core/functions/onGenerate_routes.dart';
import 'core/utils/app_colors.dart';
import 'modules/splash/views/splash_view.dart';

class MovirApp extends StatelessWidget {
  const MovirApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: AppColors.darkColor,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
