import 'package:flutter_chat_app/view/screen/home/home_screen.dart';
import 'package:flutter_chat_app/view/screen/profile/profile_screen.dart';
import 'package:flutter_chat_app/view/screen/profile/update_profile.dart';
import 'package:get/get.dart';

import '../view/screen/Auth/sign_in.dart';
import '../view/screen/Auth/sign_up.dart';
import '../view/screen/message/chat_list_screen.dart';
import '../view/screen/message/message_screen.dart';
import '../view/screen/onboarding/onboarding_screen.dart';
import '../view/screen/splash/splash_screen.dart';
import '../view/screen/test_screen.dart';

class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String signIn = "/sign_in.dart";
  static const String splash = "/splash_screen.dart";
  static const String signUp = "/sign_up.dart";
  static const String onboarding = "/onboarding_screen.dart";
  static const String chatList = "/chat_list_screen.dart";
  static const String message = "/message_screen.dart";
  static const String home = "/home_screen.dart";
  static const String updateProfile = "/update_profile.dart";
  static const String myProfile = "/profile_screen.dart";

  static List<GetPage> routes = [
    GetPage(name: test, page: () => TestScreen()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: chatList, page: () => ChatListScreen()),
    GetPage(name: message, page: () => MessageScreen()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: updateProfile, page: () => UpdateProfile()),
    GetPage(name: myProfile, page: () => MyProfileScreen()),
  ];
}
