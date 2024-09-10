import 'dart:convert';

import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:assessment_sep_2024/models/beneficiary.dart';
import 'package:assessment_sep_2024/models/history.dart';
import 'package:assessment_sep_2024/models/top_up_option.dart';
import 'package:assessment_sep_2024/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// controllers/topup_controller.dart
class TopUpController extends GetxController {
  var beneficiaries = <Beneficiary>[].obs;
  final RxList<History> allHistory = <History>[].obs;

  final UserController userController = Get.find<UserController>();

  final historyKey = 'topup_history';

  final topUpOptions = [5, 10, 20, 30, 50, 75, 100, 1000, 4000];

  final RxInt selectedAmount = 0.obs;
  final int charge = 1;

  final totalTopUpThisMonth = 0.obs;
  final selectedMonth = DateTime.now().month.toString();
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
    loadTopupHistory();
  }

  bool canTopUpBeneficiary(double amount, Beneficiary beneficiary) {
    if (user == null) {
      return false;
    }
    return beneficiary.canTopUp(amount, user!.isVerified);
  }

  List<TopUpOption> getTopUpOptions() {
    return getTopUpOptions();
  }

  Future<bool> topUp(Beneficiary beneficiary, int amount) async {
    User? user = await userController.getCurrentUser();
    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    double paidAmount = amount + 1;

    // Check if the user has enough balance
    final double remainingBalance = user.getBalanceAmountInMonth(selectedMonth);
    if (remainingBalance < amount) {
      Get.snackbar(
        'Error',
        'Insufficient balance',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }

    final int monthlyLimitPerBeneficiary = user.isVerified ? 500 : 1000;

    // Check if the top-up amount exceeds the monthly limit for the beneficiary
    if (beneficiary.monthlyTopUpAmount + amount > monthlyLimitPerBeneficiary) {
      Get.snackbar(
        'Error',
        'Monthly top-up limit exceeded for this beneficiary',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }

    // Check if the user has enough balance including the charge
    final int totalAmount = amount + charge;
    if (remainingBalance < amount) {
      Get.snackbar('Error', 'Insufficient balance');
      return false;
    }

    // Deduct the amount from the beneficiary's monthly top-up amount
    beneficiary.monthlyTopUpAmount += amount;
    totalTopUpThisMonth.value += amount;

    user.topUp(paidAmount, selectedMonth);

    // Save the top-up history
    await saveTopupHistory(beneficiary, amount);

    return true;
  }

  // Method to load beneficiary list from SharedPreferences
  Future<void> loadTopupHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final beneficiaryListJson = prefs.getStringList('history') ?? [];
    allHistory.value = beneficiaryListJson
        .map((h) => History.fromJson(jsonDecode(h)))
        .toList();
  }

  // Method to save beneficiary list to SharedPreferences
  Future<void> saveTopupHistory(Beneficiary beneficiary, amount) async {
    final newHisotry = History(
      beneficiaryId: beneficiary.beneficiaryId,
      userId: beneficiary.userId,
      fullName: beneficiary.fullname,
      nickname: beneficiary.nickname,
      amount: amount.toString(),
      date: DateTime.now().toString(),
      phoneNumber: beneficiary.phoneNumber,
    );
    allHistory.add(newHisotry);
    final prefs = await SharedPreferences.getInstance();
    final historyJson = allHistory.map((h) => jsonEncode(h.toJson())).toList();
    await prefs.setStringList('history', historyJson);
  }

  void onSubmit(Beneficiary beneficiary) async {
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

    if (await topUp(beneficiary, amount)) {
      Get.snackbar('Success', 'Top Up Successful');
      saveTopupHistory(beneficiary, amount);
    } else {
      Get.snackbar('Error', 'Top Up Failed');
    }
  }
}
