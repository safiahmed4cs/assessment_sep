import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Add Beneficiary', () {
    final controller = BeneficiaryController();
    controller.addBeneficiary(
      fullname: 'John Smith',
      nickname: 'John',
      phoneNumber: '0501234567',
    );
    expect(controller.beneficiaries.length, 1);
  });

  test('Remove Beneficiary', () {
    final controller = BeneficiaryController();
    controller.addBeneficiary(
      fullname: 'John Duke',
      nickname: 'Duke',
      phoneNumber: '0501236546',
    );
    // controller.removeBenificiary(beneficiary);
    expect(controller.beneficiaries.length, 0);
  });
}
