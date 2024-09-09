import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:get/get.dart';

class BeneficiaryController extends GetxController {
  var fullname = ''.obs;
  var nickname = ''.obs;
  var phoneNumber = ''.obs;
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

  void savePhoneNumber(String? value) {
    if (value != null) {
      phoneNumber.value = value;
    }
  }
}
