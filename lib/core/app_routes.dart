import 'package:get/get.dart';

import '../view/screen/Auth/sign_in.dart';
import '../view/screen/splash/splash_screen.dart';
import '../view/screen/test_screen.dart';


class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String signIn = "/sign_in.dart";
  static const String splash = "/splash_screen.dart";


  static List<GetPage> routes = [
    GetPage(name: test, page: () => TestScreen()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: splash, page: () => SplashScreen()),

  ];
}
