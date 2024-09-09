import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeneficiaryService extends GetxService {
  final RxList<Beneficiary> beneficiaries = <Beneficiary>[].obs;

  Future<void> loadBeneficiaries() async {
    final prefs = await SharedPreferences.getInstance();
    final beneficiaryList = prefs.getStringList('beneficiaries') ?? [];

    beneficiaries.clear();
    for (final beneficiary in beneficiaryList) {
      final parts = beneficiary.split(',');
      if (parts.length == 4) {
        beneficiaries.add(
          Beneficiary(
            fullname: parts[0],
            nickname: parts[1],
            phoneNumber: parts[2],
            isVerified: parts[3] == 'true',
          ),
        );
      }
    }
  }

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

    final newBeneficiary = Beneficiary(
      fullname: fullname,
      nickname: nickname,
      phoneNumber: phoneNumber,
      isVerified: false,
    );
    beneficiaries.add(newBeneficiary);

    final prefs = await SharedPreferences.getInstance();
    final beneficiaryList = beneficiaries
        .map(
          (b) => '${b.fullname},${b.nickname},${b.phoneNumber},${b.isVerified}',
        )
        .toList();
    await prefs.setStringList('beneficiaries', beneficiaryList);

    Get.snackbar(
      'Success',
      'Beneficiary added successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  Future<void> deleteBeneficiary(
    BuildContext context,
    Beneficiary beneficiary,
  ) async {
    final shouldDelete = await showDialog<bool>(
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
                Navigator.of(context).pop(true);
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

    if (shouldDelete == true) {
      beneficiaries.remove(beneficiary);

      final prefs = await SharedPreferences.getInstance();
      final beneficiaryList =
          beneficiaries.map((b) => '${b.fullname},${b.phoneNumber}').toList();
      await prefs.setStringList('beneficiaries', beneficiaryList);

      Get.snackbar(
        'Success',
        'Beneficiary deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> verifyBeneficiary(
    BuildContext context,
    Beneficiary beneficiary,
  ) async {
    final index = beneficiaries.indexWhere(
      (b) => b.phoneNumber == beneficiary.phoneNumber,
    );
    if (index == -1) {
      return;
    }
    beneficiaries[index].isVerified = true;

    Beneficiary verifiedBeneficiary = beneficiaries[index];
    verifiedBeneficiary.isVerified = false;
    beneficiaries.removeAt(index);

    Future.delayed(const Duration(milliseconds: 100), () {
      verifiedBeneficiary.isVerified = true;
      verifiedBeneficiary.monthlyTopUp = 500;
      beneficiaries.insert(0, verifiedBeneficiary);
    });

    final prefs = await SharedPreferences.getInstance();
    final beneficiaryList = beneficiaries
        .map(
          (b) => '${b.fullname},${b.nickname},${b.phoneNumber},${b.isVerified}',
        )
        .toList();
    await prefs.setStringList('beneficiaries', beneficiaryList);

    Get.snackbar(
      'Success',
      'Beneficiary verified successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
    Navigator.of(context).pop();
  }
}
