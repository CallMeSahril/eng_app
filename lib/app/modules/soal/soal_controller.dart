import 'package:eng_app/app/widgets/result_bottom_sheer.dart';
import 'package:get/get.dart';

class SoalController extends GetxController {
  RxInt selectedIndex = (-1).obs;
  RxBool isAnswered = false.obs;
  RxBool isCorrect = false.obs;

  void selectAnswer(int index, bool correct) {
    selectedIndex.value = index;
    isAnswered.value = true;
    isCorrect.value = correct;

    Future.delayed(const Duration(milliseconds: 600), () {
      Get.bottomSheet(
        ResultBottomSheet(isCorrect: isCorrect.value),
        isDismissible: false,
      );
    });
  }
}
