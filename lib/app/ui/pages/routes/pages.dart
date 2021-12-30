import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/home/home_page.dart';
import 'package:google_maps_test/app/ui/pages/login/login_page.dart';
import 'package:google_maps_test/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:google_maps_test/app/ui/pages/sign_in/sign_in_page.dart';
import 'package:google_maps_test/app/ui/pages/splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.LOGIN: (_) => const LoginPage(),
    Routes.SIGNIN: (_) => const SignInPage(),
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) => const HomePage(),
  };
}
