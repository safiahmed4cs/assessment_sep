import 'dart:convert';

import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:assessment_sep_2024/models/beneficiary.dart';
import 'package:assessment_sep_2024/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeneficiaryController extends GetxController {
  //Import BenificiaryService
  final RxList<Beneficiary> allBenificiaries = <Beneficiary>[].obs;
  final RxList<Beneficiary> beneficiaries = <Beneficiary>[].obs;
  final UserController userController = Get.find<UserController>();

  var fullname = ''.obs;
  var nickname = ''.obs;
  var phoneNumber = ''.obs;
  var isVerified = false.obs;
  var monthlyTopUp = 0.0.obs;
  var userBalance = 5000.0.obs;

  @override
  void onInit() {
    loadBeneficiaries();
    super.onInit();
  }

  // Validate the fullname input
  String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a fullname';
    }
    if (value.length > 100) {
      return 'Fullname cannot be more than 100 characters';
    }
    return null;
  }

  // Validate the nickname input
  String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a nickname';
    }
    if (value.length > 20) {
      return 'Nickname cannot be more than 20 characters';
    }
    return null;
  }

  // Validate the phone number input
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    if (value.length != 13) {
      return 'Mobile number must be 9 digits after +971';
    }
    return null;
  }

  // save the fullname input
  void saveFullName(String? value) {
    if (value != null) {
      fullname.value = value;
    }
  }

  // save the nickname input
  void saveNickname(String? value) {
    if (value != null) {
      nickname.value = value;
    }
  }

  // save the phone number input
  void savePhoneNumber(String? value) {
    if (value != null) {
      phoneNumber.value = value;
    }
  }

  //Load benificiaries from shared preferences and add to the list where user id is currentuser userid
  Future<void> loadBeneficiaries() async {
    User? currentUser = await userController.getCurrentUser();
    if (currentUser == null) {
      return;
    }
    final currentUserId = currentUser.userId;

    beneficiaries.clear();
    allBenificiaries.clear();
    await _loadBeneficiaryList();
    for (final beneficiary in allBenificiaries) {
      // this is to have list of benificiaries where user id is current user id
      if (beneficiary.userId == currentUserId) {
        beneficiaries.add(beneficiary);
      }
    }
  }

  // Add a new beneficiary
  Future<void> addBeneficiary({
    required String fullname,
    required String nickname,
    required String phoneNumber,
  }) async {
    if (beneficiaries.length >= 5) {
      Get.snackbar(
        'Error',
        'You can only add up to 5 beneficiaries.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }
    User? user = userController.currentUser.value;
    if (user == null) {
      Get.snackbar(
        'Error',
        'User not found. Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    final newBeneficiary = Beneficiary(
      userId: user.userId,
      fullname: fullname,
      nickname: nickname,
      phoneNumber: phoneNumber,
      beneficiaryId: DateTime.now().toString(),
    );
    beneficiaries.add(newBeneficiary);
    allBenificiaries.add(newBeneficiary);

    Get.snackbar(
      'Success',
      'Beneficiary added successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );

    saveBeneficiaryList();
  }

  // Method to save beneficiary list to SharedPreferences
  Future<void> saveBeneficiaryList() async {
    final prefs = await SharedPreferences.getInstance();
    final beneficiaryListJson = allBenificiaries
        .map((beneficiary) => jsonEncode(beneficiary.toJson()))
        .toList();
    await prefs.setStringList('beneficiary_list', beneficiaryListJson);
  }

  // Method to load beneficiary list from SharedPreferences
  Future<void> _loadBeneficiaryList() async {
    final prefs = await SharedPreferences.getInstance();
    final beneficiaryListJson = prefs.getStringList('beneficiary_list') ?? [];
    allBenificiaries.value = beneficiaryListJson
        .map((beneficiary) => Beneficiary.fromJson(jsonDecode(beneficiary)))
        .toList();
  }

  // Remove a beneficiary
  Future<void> deleteBeneficiary(
    BuildContext context,
    String beneficiaryId,
  ) async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this beneficiary?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteHandler(context, beneficiaryId);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteHandler(context, String beneficiaryId) async {
    allBenificiaries.removeWhere(
        (beneficiary) => beneficiary.beneficiaryId == beneficiaryId);

    final prefs = await SharedPreferences.getInstance();
    final beneficiaryListJson = allBenificiaries
        .map((beneficiary) => jsonEncode(beneficiary.toJson()))
        .toList();
    await prefs.setStringList('beneficiary_list', beneficiaryListJson);

    Get.snackbar(
      'Success',
      'Beneficiary deleted successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
    Navigator.of(context).pop();

    loadBeneficiaries();
  }
}
