import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:get/get.dart';

class BeneficiaryController extends GetxController {
  var fullname = ''.obs;
  var nickname = ''.obs;
  var phoneNumber = ''.obs;
  var isVerified = false.obs;
  var monthlyTopUp = 0.0.obs;
  var userBalance = 5000.0.obs;

  var beneficiaries = <Beneficiary>[].obs;

  void addBeneficiary(Beneficiary beneficiary) {
    if (beneficiaries.length < 5) {
      beneficiaries.add(beneficiary);
    }
  }

  void removeBeneficiary(Beneficiary beneficiary) {
    beneficiaries.remove(beneficiary);
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    if (value.length != 13) {
      return 'Mobile number must be 9 digits after +971';
    }
    return null;
  }

  void saveFullName(String? value) {
    if (value != null) {
      fullname.value = value;
    }
  }

  void saveNickname(String? value) {
    if (value != null) {
      nickname.value = value;
    }
  }

  void savePhoneNumber(String? value) {
    if (value != null) {
      phoneNumber.value = value;
    }
  }

  bool requestTopUp(Beneficiary beneficiary, double amount) {
    double maxTopUp = isVerified.value ? 500 : 1000;
    if (beneficiary.monthlyTopUp + amount > maxTopUp ||
        userBalance.value < amount + 1) {
      return false;
    }
    userBalance.value -= (amount + 1);
    beneficiary.monthlyTopUp += amount;
    return true;
  }
}
