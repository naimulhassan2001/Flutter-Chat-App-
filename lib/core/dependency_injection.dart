


import 'package:get/get.dart';

import '../controller/Auth/sign_in_controller.dart';
import '../controller/Auth/sign_up_controller.dart';
import '../controller/home/home_controller.dart';
import '../controller/message/message_controller.dart';



class DependencyInjection extends Bindings {



  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);


  }
}
