import 'package:assessment_sep_2024/models/user.dart';
import 'package:assessment_sep_2024/screens/benificiaries/beneficiary_list_screen.dart';
import 'package:assessment_sep_2024/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserController extends GetxController {
  var currentUser = Rxn<User>();

  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', jsonEncode(user.toJson()));
    currentUser.value = user;

    //Navigate to BeneficiaryListScreen
    Get.offAll(() => BeneficiaryListScreen());
  }

  void logout() async {
    Get.offAll(() => HomeScreen());
  }

  void clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
