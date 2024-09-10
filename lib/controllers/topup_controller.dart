import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:assessment_sep_2024/models/top_up_option.dart';
import 'package:assessment_sep_2024/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// controllers/topup_controller.dart
class TopUpController extends GetxController {
  var beneficiaries = <Beneficiary>[].obs;
  final UserController userController = Get.find<UserController>();

  final topUpOptions = [5, 10, 20, 30, 50, 75, 100];

  final RxInt selectedAmount = 0.obs;
  final int charge = 1;

  final totalTopUpThisMonth = 0.obs;
  final amountController = TextEditingController();

  void selectAmount(int amount) {
    selectedAmount.value = amount;
  }

  int get totalAmount => selectedAmount.value + charge;

  User? get user => userController.currentUser.value;

  @override
  void onInit() {
    super.onInit();
    selectedAmount.value = 0;
    amountController.clear();
  }

  bool canTopUpBeneficiary(double amount, Beneficiary beneficiary) {
    if (user == null) {
      return false;
    }
    return beneficiary.canTopUp(amount, user!.isVerified);
  }

  bool canUserTopUp(double amount) {
    if (user == null) {
      return false;
    }
    return user!.canTopUp(amount);
  }

  void topUpBeneficiary(Beneficiary beneficiary, double amount) {
    if (user == null) {
      Get.snackbar("Error", "User not found.");
      return;
    }
    if (canTopUpBeneficiary(amount, beneficiary) && canUserTopUp(amount)) {
      // Deduct the amount + transaction fee from user's balance
      userController.currentUser.update((u) {
        u!.balance -= (amount + 1); // AED 1 transaction fee
        u.totalMonthlyTopUp += amount;
      });

      // Update beneficiary's top-up amount
      beneficiary.monthlyTopUpAmount += amount;

      Get.snackbar("Success",
          "Top-up of AED $amount successful for ${beneficiary.nickname}");
    } else {
      Get.snackbar(
          "Error", "Top-up failed due to limits or balance constraints.");
    }
  }

  List<TopUpOption> getTopUpOptions() {
    return getTopUpOptions();
  }

  bool topUp(Beneficiary beneficiary, int amount) {
    // Deduct the amount from the wallet balance
    // if (beneficiary.walletBalance >= amount) {
    //   beneficiary.walletBalance -= amount;
    //   totalTopUpThisMonth.value += amount;
    //   return true;
    // }
    return false;
  }

  void saveTopUpHistory(Beneficiary beneficiary, int amount) {
    // Save the top-up history
    // This could involve saving to a database or shared preferences
  }

  void onSubmit(Beneficiary beneficiary) {
    final amount = int.tryParse(amountController.text) ?? 0;

    bool isVerified = false;
    User? user = UserController().currentUser.value;
    if (user != null) {
      isVerified = user.isVerified;
    }

    final maxAmount = isVerified ? 500 : 1000;

    if (amount <= 0 || amount > maxAmount) {
      Get.snackbar('Error', 'Amount must be between 1 and $maxAmount AED');
      return;
    }

    if (totalTopUpThisMonth.value + amount > 3000) {
      Get.snackbar('Error', 'Monthly top-up limit of AED 3000 exceeded');
      return;
    }

    if (topUp(beneficiary, amount)) {
      Get.snackbar('Success', 'Top Up Successful');
      saveTopUpHistory(beneficiary, amount);
    } else {
      Get.snackbar('Error', 'Top Up Failed');
    }
  }
}
