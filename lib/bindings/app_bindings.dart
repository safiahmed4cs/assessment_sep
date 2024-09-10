import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(BeneficiaryController());
    Get.put(TopUpController());
  }
}
