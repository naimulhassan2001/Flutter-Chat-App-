import 'package:get/get.dart';

class HomeController extends GetxController {
  int index = 0;

  changeIndex(index) {
    this.index = index;
    update();
  }
}
