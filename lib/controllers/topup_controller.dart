import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpController extends GetxController {
  final topUpOptions = [5, 10, 20, 30, 50, 75, 100];
  final totalTopUpThisMonth = 0.obs;
  final amountController = TextEditingController();
  final isVerified = false.obs;

  void setBeneficiary(Beneficiary beneficiary) {
    isVerified.value = beneficiary.isVerified;
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
    final maxAmount = isVerified.value ? 500 : 1000;

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
