import 'package:assessment_sep_2024/models/user.dart';
import 'package:assessment_sep_2024/screens/benificiaries/beneficiary_list_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserController extends GetxController {
  var currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('current_user');
    if (userJson != null) {
      currentUser.value = User.fromJson(jsonDecode(userJson));
      Get.offAll(() => BeneficiaryListScreen());
    }
  }

  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', jsonEncode(user.toJson()));
    currentUser.value = user;
    Get.offAll(() => BeneficiaryListScreen());
  }
}
